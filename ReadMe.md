
# MLDS NoteBook

Machine Learning and Data Science Env, with notebook jupyter

## Description
based on **jupyter** & **luissalgadofreire/h2o-pysparkling** docker images

-   [luissalgadofreire/h2o-pysparkling](https://hub.docker.com/r/luissalgadofreire/h2o-pysparkling/~/dockerfile/)  
    -   This image creates a *machine learning environment* using **h2o's sparkling water** in **pysparkling** mode 
        -   image based on   [jupyter/all-spark-notebook](https://hub.docker.com/r/jupyter/all-spark-notebook/) 
                -   **Python3**, **R**, and **Scala** support for **Apache Spark**, optionally on **Mesos**

- [jupyter/datascience-notebook](https://hub.docker.com/r/jupyter/datascience-notebook/)  
    -   Libraries for _data analysis_ from the **Julia**, **Python3**, and **R** communities 

- [jupyter/tensorflow-notebook](https://hub.docker.com/r/jupyter/tensorflow-notebook/)  
    - Popular Python *deep learning libraries*: **Tensorflow**, **Keras** + **Theano**

- [xgboost](https://xgboost.readthedocs.io/en/latest/)
    - Scalable and Flexible **Gradient Boosting**

- [SoS](https://vatlab.github.io/sos-docs/index.html#introduction)
    - Notebook environment for both interactive data analysis and batch data processing  (**one notebook, multiple languages**)

# Installation
    docker pull luluisco/mlds-notebook:latest


# Run
## Basic
    docker run --rm -ti -p 8888:8888 luluisco/mlds-notebook:latest
    
## With Volumes

### Persist Added Packages ( R, Julia, Python(pip))

    -v custom:/home/mlds/.custom
(create volume custom if not exist, in make cmd is the parameter 'custom')
### Persist Work
    -v $PWD/workXXX:/home/mlds/work
(workXXX your directory with your work, in make cmd is the parameter 'work')

## Ports
    -p 8888:8888 -p 6006:6006
### Jupyter notebook
-   8888 
### TensorFlow Tensorboard
-   6006
### H2O
- 54321-54331 #H2O flow 
### Spark
- 7077 #spark port
- 8080 #spark master port
- 8081 #spark slave port
- 60
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
    - choose ports between XXXMin and XXXMax ( set XXXMax or XXXNb) (XXX = portNb,portTensorBoard, portH2o, portSpark ,etc.....)
- multiple confs
- start-master
- start-slave
- exec
- logs
- open
## DOWNLOAD
Put the directory "bashCmd" in the root of your project
- download [bashCmd.zip](https://github.com/luluperet/mlds-notebook/raw/master/bashCmd.zip)
- `wget -q https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip && unzip bashCmd.zip && cd bashCmd `
- `curl -s https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip -o bashCmd.zip && unzip bashCmd.zip && cd bashCmd`
    - Warning !! don't move Makefile or getP,  if not change variable 'work' and 'getP'
- `curl -sL tinyurl.com/mlds-notebook-bash-cmd-sh | bash`
## MAKE CMD
- make | make help # get help
- make mlds
    ### Images
     - latest=:latest    
     - image=luluisco/mlds-notebook
     - cmd=mlds<i></i>.sh  
         - cmd to execute after run
         -  execute mlds<i></i>.sh by default(open notebook and set token to mlds)
     - more=  
         - is empty
         - supplementary parameters 
     - getP=getP 
         - command for find port
     - quiet=no
     ### Params Presence
   - debug=-d  
       - docker run -d (detact)
       - could be -ti
   - run_rm=--rm 
       - remote container after die
    ### Volumes
     - custom=      
         - is empty
         - if set create volume for /home/mlds/.custom
         - could be an volume name or path (think to set with long path "$PWD/customXXX")
     - work=../work    
         - if set create volume for /home/mlds/work
         - path to work #TODO POSSIBILITY SET VOLUME
       - **INTERNAL**
          - home=/home/mlds/ #internal
          - home_custom=.custom #internal
          - home_work=work #internal
     ### Ports
     -  #### Jupyter notebook
          - **INTERNAL**
             - portNb=8888 #internal jupyter notebook port
         - portNbMin=8888 #jupyter begin port
         - portNbNb=10 #nb of available port
         - portNbMax=portNbMin + portNbNb #or set manually
      -  #### Spark
            - **INTERNAL**
              - portSpark=7077  #internal spark port
              - portSparkMaster=8080 #internal spark master port
              - portSparkSlave=8081 #internal spark slave port
              - portSparkRest=6066 #internal spark rest port
              - portSparkContextB=4040 #internal spark context begin port
              - portSparkContextE=4050 #internal spark context end port
           - **MIN**
               - portSparkMin=7077 #spark begin port
               - portSparkMasterMin=8080 #spark master begin port
               - portSparkSlaveMin=8081 #spark slave begin port
               - portSparkRestMin=6066 #spark rest begin port
               - portSparkContextBMin=4040 #spark context begin port
               - portSparkContextEMin=4050 #spark context end port
            - **NB**
                 - portSparkNb=10 #nb of available ports for each run
                - portSparkMasterNb=10 #spark master nb of available ports for each run
                - portSparkSlaveNb=10 #spark slave nb of available ports for each run
                - portSparkRestNb=10 #sparke rest nb of available ports for each run
                - portSparkContextBNb=100 #spark context begin port 100 because 10 port available for each run (nb of available ports for each run)
                - portSparkContextENb=100 #spark context end port 100 because 10 port available for each run (nb of available ports for each run)
             - **MAX**
                - portSparkMasterMax=portSparkMasterMin + portSparkMasterNb  #or set manually
                - portSparkSlaveMax=portSparkSlaveMin + portSparkSlaveNb #or set manually
                - portSparkRestMax=portSparkRestMin + portSparkRestNb #or set manually
                - portSparkContextBMax=portSparkContextBMin + portSparkContextBNb #or set manually
                - portSparkContextEMax=portSparkContextEMin + portSparkContextENb #or set manually
                - portSparkMax=portSparkMin + portSparkNb #or set manually

        - #### H2O
            - **INTERNAL**
                - portH2o=54321-54331 #internal h2o ports
            - portH2oMin=54321 #H2o begin port
            - portH2oNb=100 #nb of availave ports 100 because for 10 ports for each instance 10^2 = 100 
            - portH2oMax=portH2oMin + portH2oNb #or set manually
        - #### TensorFlow TensorBoard
           -  #### INTERNAL  
                - portTensorBoard=6006 internal tensorflow tensorboard port
            - portTensorBoardMin=6006 #TensorBoard begin port
            - portTensorBoardNb=10 #nb of available ports
            - portTensorBoardMax=portTensorBoardMin + portTensorBoardNb #or set Manualy

    ### SPECIAL
     - printCommand="yes" 
         - show command
- `docker run ${name} "${debug}" "${run_rm}" $VOLUMES $PORTS  ${more} "${image}${latest}"  ${cmd}`

- Exemples: 
    - `make mlds`
    - `make mlds work=work/`
    - `make mlds custom=customMyProject work=../work`
    - etc
## OTHERS CMD
When the container is running, go to the terminal and write </br>
`$ export MLDS_C_CURR="NAME_OR_ID_OF_CONTAINER"`
 ### Start Master Spark
   - `$ ./start-master.sh [id_or_name_of_container_or_nothing_if_MLDS_C_CURR_IS_SET]`
 ### Start Slave Spark
- `$ ./start-slave.sh [id_or_name_of_container_or_nothing_if_MLDS_C_CURR_IS_SET] IP_OF_MASTER (192.168.X.X or localhost if local)`
### Execute command in container (detach by default)
   - `$ ./exec.sh [-ti_or_nothing] CMD_TO_EXECUTE` **if MLDS_C_CURR is set**
   - `$ ./exec.sh id_or_name_of_container CMD_TO_EXECUTE [-ti_or_nothing]`
## Open browser (mac) (localhost)
-   `open nb`
-   `open IP`