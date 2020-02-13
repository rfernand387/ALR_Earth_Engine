# **ALR Eearth Engine**


## **Set Up**
Pre-requisites:
* Git
* Anaconda
* Linux (Environment was tested on Ubuntu 18.04)

Once you have anaconda set up and the repository cloned or downloaded, to set up the conda environment you can use the `eeAlr.yml` file to generate a new Conda environment from which the Jupyter Notebooks can be run.

Create the environment:

```
conda env create -f eeAlr.yml
```

Activate the new environment:

```
conda activate eeAlr
```

Verify that the new environment was installed correctly:

```
conda env list
```

There should be an asterisk next to eeAlr showing that it is the active environment.

You can now launch Jupyter Lab (a newer web based IDE for jupyter notebboks) in the current directory with the cloned git repository.

`$ jupyter lab`

The notebooks should be functional with Earth Engine as my credentials are stored in `credentials.json`. If Earth Engine is not working you may have to add a line in the scripts to trigger the authentication flow for a new machine after as below

```
import ee
ee.Authenticate()     # New line
ee.Initialize()
```

You can also trigger the authentication flow from the command line interface for Earth Engine using 

`$ earthengine authenticate`

---

## **Progress of Work/Learning**

The file names may be a little confusing so here is the order in which I worked on each Jupyter Notebook
1. `ee_demo_test.ipynb`
2. `data_exports.ipynb`
3. `landsat8_B4_skl_prediction.ipynb`
4. `landsat8_B4_skl_keras_prediction.ipynb`
5. `ee_lar_implementation.ipynb`
6. `LAI_FAPAR_FCOVER_Prediction.ipynb`
7. `ALR_Client_Side.ipynb`