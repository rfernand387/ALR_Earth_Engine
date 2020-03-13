function [beta, A, prediction, C, c, gamma] = Copy_of_lars(X, Y, n_nonzero)

    % Output:
    % beta -- coefficients
    % A -- a sequence of indices that indicate the order of variable inclusions;
    % prediction -- history of estimated mean vector;
    % C -- history of maximal current absolute corrrelations;
    % c -- history of current corrrelations;
    % gamma: history of LARS step size.

    [n,p] = size(X);

    m = min(p,n-1); % Maximal number of variables in the final active set

    prediction = zeros(n,1);    % Mean vector
    gamma = []; % LARS step lengths
    A = [];
    Ac = 1:p;
    beta = [];
    nVars = 0;
    i = 0;
    prediction_old = zeros(n,1);

    iterLimit = min(n_nonzero, m);
    % LARS loop
    while nVars < iterLimit
        i = i+1;

        c = X'*(Y-prediction);  % Current correlation
        C = max(abs(c));    % Maximal current absolute correlation

        if 1 == i, addVar = find(C==abs(c)); end
        
        A = [A,addVar]; % Add one variable to active set
        nVars = nVars+1;
        
        
        s_A = sign(c(A));

        Ac = setdiff(1:p,A);    % Inactive set

        nZeros = length(Ac);

        X_A = X(:,A);

        G_A = X_A'*X_A; % Gram matrix

        invG_A = inv(G_A);

        A_A = 1/sqrt(s_A'*invG_A*s_A);

        w_A = A_A*invG_A*s_A;   % Coefficients of equiangular vector u_A

        u_A = X_A*w_A;  % Equiangular vector

        a = X'*u_A; % Angles between x_j and u_A

        gammaTest = zeros(nZeros,2);
        if nVars == m
            gamma(i) = C/A_A;   % Move to the least squares projection
        else
            for j = 1:nZeros
                jj = Ac(j);
                gammaTest(j,:) = [(C-c(jj))/(A_A-a(jj)), (C+c(jj))/(A_A+a(jj))];
            end
            [gamma(i), min_i, ~] = minplus(gammaTest);
            addVar = unique(Ac(min_i));
        end

        prediction = prediction_old + gamma(i)*u_A; % Update mean vector
        prediction_old = prediction;
        
        beta = [beta, linsolve(X, prediction)];

    end
    
    
end

% Normalize columns of X to have mean zero and length one.
function sX = normalize(X)

[n,~] = size(X);
sX = X-repmat(mean(X),n,1);
sX = sX*diag(1./sqrt(ones(1,n)*sX.^2));

end

% Find the minimum and its index over the (strictly) positive part of X
% matrix
function [m, I, J] = minplus(X)

% Remove complex elements and reset to Inf
[I,J] = find(0~=imag(X));
for i = 1:length(I)
    X(I(i),J(i)) = Inf;
end

X(X<=0) = Inf;
m = min(min(X));
[I,J] = find(X==m);

end