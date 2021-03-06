# **ALR Eearth Engine**


## **Set Up**
Pre-requisites:
* Anaconda (default installation)

Create the environment with the necessary packages:

`$ conda create -n eeALR ipython jupyterlab numpy scipy pandas matplotlib scikit-learn tensorflow`

Activate the new environment:

`$ conda activate eeALR`

Verify that the new environment was installed correctly:

`$ conda env list`

There should be an asterisk next to eeALR showing that it is the active environment.

Install the Google Earth Engine API from conda-forge

`$ conda install -c conda-forge earthengine-api`

You can now launch Jupyter Lab (a newer web based IDE for jupyter notebboks) in the current directory with the cloned git repository.

`$ jupyter lab`

Make sure you are always in the correct environment (with the necessary packages) before launching jupyter lab.

---

## **Remote Development**

If the installation is done on a remote machine, you can either use X11 display forwarding to access the jupyter lab GUI, or port forward the jupyter server to a port on your local machine and access the GUI through the local port. Port forwarding is recommended as X11 display forwarding can be quite slow (the protocol was not designed for modern GUIs).

To port forward the jupyter server and access the GUI locally you will need to install one more package:

`$ pip install jupyter-http-over-ws`

With an openSSH client installed (MobaXterm is recommended) run the following command in a local terminal (bash, cmd)

`$ ssh -N -f -L localhost:YYYY:localhost:XXXX remote_username@remote_host_IP_or_Name`

Where `YYYY` is the local port you would like to forward to, and `XXXX` is the port the jupyter server is running on at the remote machine. (By default jupyter lab launches at port 8888 if available. In either case, when launched it will say in the terminal which port it is running on)

You can launch the jupyter lab (with access to the files and terminal from the remote machine) by using any browser and going to

`localhost:YYYY/lab`

---

## **Authentication with Earth Engine**

The notebooks should be functional with Earth Engine as my credentials are stored in `credentials.json`. If Earth Engine is not working you may have to add a line in the scripts to trigger the authentication flow for a new machine after as below

```
import ee
ee.Authenticate()     # New line
ee.Initialize()
```

You can also trigger the authentication flow from the command line interface for Earth Engine (use an Anaconda Prompt window if on Windows):

`$ earthengine authenticate`

---

## **Progress of Work/Learning**

The file names may be a little confusing so here is the order in which I worked on each Jupyter Notebook
1. `ee_demo_test.ipynb`
2. `data_exports.ipynb`
3. `landsat8_B4_prediction.ipynb`
4. `ee_lar_implementation.ipynb`
5. `normalized_predictions.ipynb`
6. `skl_keras_predictions.ipynb`
7. `ALR_Client_Side.ipynb`