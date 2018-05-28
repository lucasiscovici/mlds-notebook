# MLDS NoteBook

Machine Learning and Data Science Env, with notebook jupyter

## Description
based on **jupyter** & **luissalgadofreire/h2o-pysparkling** docker images

-	[luissalgadofreire/h2o-pysparkling](https://hub.docker.com/r/luissalgadofreire/h2o-pysparkling/~/dockerfile/)  
	-	This image creates a *machine learning environment* using **h2o's sparkling water** in **pysparkling** mode 
		-	image based on   [jupyter/all-spark-notebook](https://hub.docker.com/r/jupyter/all-spark-notebook/) 
				-	**Python3**, **R**, and **Scala** support for **Apache Spark**, optionally on **Mesos**

- [jupyter/datascience-notebook](https://hub.docker.com/r/jupyter/datascience-notebook/)  
	-	Libraries for _data analysis_ from the **Julia**, **Python3**, and **R** communities 

- [jupyter/tensorflow-notebook](https://hub.docker.com/r/jupyter/tensorflow-notebook/)  
	- Popular Python *deep learning libraries*: **Tensorflow**, **Keras** + **Theano**

- [xgboost](https://xgboost.readthedocs.io/en/latest/)
	- Scalable and Flexible **Gradient Boosting**

- [SoS](https://vatlab.github.io/sos-docs/index.html#introduction)
	- Notebook environment for both interactive data analysis and batch data processing  (**one notebook, multiple languages**)

# Installation

	docker pull luluisco/mlds-notebook


# Run
## Basic
	docker run --rm -ti -p 8888:8888 luluisco/mlds-notebook
	
## With Volumes

### Persist Added Packages ( R, Julia, Python(pip))

	-v custom:/home/mlds/.custom
(create volume custom if not exist)
### Persist Work
	-v $PWD/workXXX:/home/mlds/work
(workXXX your directory with your work)

## Ports
	-p 8888:8888 -p 6006:6006
### Jupyter notebook
-	8888 
### TensorFlow Tensorboard
-	6006
### H2O
- 54321 
- 54322 
- 55555
### Spark
- 4040
## Notebook Token 
	`(...) start-notebook.sh --NotebookApp.token="YOUR_TOKEN"`
( token or an password (Ex: mlds))

## Run with all options

	docker run --rm -d -v custom:/home/mlds/.custom -v $PWD/work/:/home/mlds/work -p 8888:8888 -p 6006:6006 luluisco/mlds-notebook start-notebook.sh --NotebookApp.token="mlds"
# Container Infos
- Default User is **jovyan** 
	- have **root permission**
	- password: **mlds** 
        - sudo works without password (share environment variable PATH with root automatically)
        - sudo -i for root shell 
- **/home/mlds** is a *symbolic link* to **/home/jovyan**
- **/home/mlds/.custom** (or /home/jovyan/.custom) contains **all future packages** added in a container
	- python (pip install **--user**)
	- R (install.packages)
	- julia (Pkg.add)
# TODO
- PB WITH R and Julia when installing new package, it's re-install the package if already exist globally and save it in .custom/ etc
  - create package for R and julia for check if package already exist before to call the real fonction
- Add RStudio

# BASH CMD
- Automatically choose Ports
	- choose ports between XXXMin and XXXMax ( set XXXMax or XXXNb) (XXX = portNb,portTensorBoard, portH2o, portSpark )
- multiple confs
## DOWNLOAD
- download [bashCmd.zip](https://github.com/luluperet/mlds-notebook/raw/master/bashCmd.zip)
	- Warning !! don't move Makefile or getP,  if not change variable 'work' and 'getP'
## RUN CMD
- make mlds
    -   custom=custom # volume or path to directory
    -   work=work # volume or path to directory
    -   latest=:latest # tag of image
    -   image=luluisco/mlds-notebook # image
    -   cmd=mlds.sh # command execute when run container (jupyter notebook)
    -   portNb=8888 
    -   portTensorBoard=6006
    -   portH2o=54321 
    -   portSpark=4004
    -   portNbMin=8888 
    -   portTensorBoardMin=6006
    -   portH2oMin=54321
    -   portSparkMin=4004
    -   portNbNb=10
    -   portTensorBoardNb=10
    -   portH2oNb=10
    -   portSparkNb=10
    -   portNbMax=XMin+XNb
    -   portTensorBoardMax=XMin+XNb
    -   portH2oMax=XMin+XNb
    -   portSparkMax=XMin+XNb
    -   home=/home/mlds/ #Internal
    -   home_custom=.custom #Internal
    -   home_work=work #Internal
    -   debug=-d 
    -   run_rm=--rm
    -   printCommand=yes
    -   getP="./getP" # command for find port
- `docker run  $debug $run_rm  -v $custom:$home$home_custom  -v $k/$work:$home$home_work -p $d:$portSpark  -p $a:$portNb  -p $b:$portTensorBoard  -p $c:$portH2o  $image$latest  $cmd`