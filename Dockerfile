FROM jupyter/all-spark-notebook

ARG TEST_ONLY_BUILD

USER root

# Install all OS dependencies for openai gym
RUN apt-get update && apt-get install -yq --no-install-recommends \
    python-numpy \
    python-dev \
    cmake \
    zlib1g-dev \
    libjpeg-dev \
    xvfb \
    libav-tools \
    xorg-dev \
    python-opengl \
    libboost-all-dev \
    libsdl2-dev \
    swig \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ffmpeg for video handling
RUN echo "deb http://ftp.uk.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -yq --no-install-recommends ffmpeg

# Switch back to jovyan to avoid accidental container running as root
USER $NB_USER
RUN conda update -n base conda

# Add channels to conda to install custom packages
RUN conda config --add channels menpo       # for opencv

# Set the working directory
WORKDIR /home/$NB_USER/work

# Install binary packages with conda from requirements-conda.txt.
# Remove pyqt and qt pulled in for matplotlib since we're only ever going to
# use notebook-friendly backends in these images
#ONBUILD COPY requirements-conda.txt /home/jovyan/work
#ONBUILD RUN conda install --quiet --yes --file requirements-conda.txt && \
            #conda remove --quiet --yes --force qt pyqt && \
            #conda clean -tipsy

# Install python packages with pip from requirements-pip.txt
#ONBUILD COPY requirements-pip.txt /home/jovyan/work
#ONBUILD RUN pip install --no-cache-dir -r requirements-pip.txt

# Deploy application code
#ONBUILD COPY . /home/$NB_USER/work

# Install H2O pysparkling requirements
RUN pip install requests && \
    pip install tabulate && \
    pip install six && \
    pip install future && \
    pip install colorama

# Expose H2O Flow UI ports
EXPOSE 54321
EXPOSE 54322
EXPOSE 55555

# Install H2O sparkling water
RUN \
    cd /home/$NB_USER && \
    wget http://h2o-release.s3.amazonaws.com/sparkling-water/rel-2.1/7/sparkling-water-2.1.7.zip && \
    unzip sparkling-water-2.1.7.zip && \
    cd sparkling-water-2.1.7

# Add sparkling-water's /bin folder to path
ENV PATH="/home/$NB_USER/sparkling-water-2.1.7/bin:${PATH}"

# Switch back to jovyan to avoid container running accidentally as root
#USER $NB_USER


USER root

# Julia dependencies
# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_PKGDIR=/opt/julia
ENV JULIA_VERSION=0.6.2

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    echo "dc6ec0b13551ce78083a5849268b20684421d46a7ec46b17ec1fab88a5078580 *julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | sha256sum -c - && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz
RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# Show Julia where conda libraries are \
RUN mkdir /etc/julia && \
    echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    mkdir $JULIA_PKGDIR && \
    chown $NB_USER $JULIA_PKGDIR && \
    fix-permissions $JULIA_PKGDIR


USER $NB_UID

# R packages
# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'rpy2=2.8*' \
    'r-base=3.4.1' \
    'r-irkernel=0.8*' \
    'r-plyr=1.8*' \
    'r-devtools=1.13*' \
    'r-tidyverse=1.1*' \
    'r-shiny=1.0*' \
    'r-rmarkdown=1.8*' \
    'r-forecast=8.2*' \
    'r-rsqlite=2.0*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' \
    'r-randomforest=4.6*' \
    'r-htmltools=0.3*' \
    'r-sparklyr=0.7*' \
    'r-htmlwidgets=1.0*' \
    'r-hexbin=1.27*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


# Add Julia packages. Only add HDF5 if this is not a test-only build since
# it takes roughly half the entire build time of all of the images on Travis
# to add this one package and often causes Travis to timeout.
#
# Install IJulia as jovyan and then move the kernelspec out
# to the system share location. Avoids problems with runtime UID change not
# taking effect properly on the .local folder in the jovyan home dir.
USER root
RUN apt-get install -y hdf5-tools
USER $NB_UID

RUN julia -e 'Pkg.init()' && \
    julia -e 'Pkg.update()' && \
    (test $TEST_ONLY_BUILD || julia -e 'Pkg.add("HDF5")') && \
    julia -e 'Pkg.add("Gadfly")' && \
    julia -e 'Pkg.add("RDatasets")' && \
    julia -e 'Pkg.add("IJulia")' && \
    # Precompile Julia packages \
    julia -e 'using IJulia' && \
    # move kernelspec out of home \
    mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/ && \
    chmod -R go+rx $CONDA_DIR/share/jupyter && \
    rm -rf $HOME/.local && \
    fix-permissions $JULIA_PKGDIR $CONDA_DIR/share/jupyter 


    # Install Tensorflow
RUN conda install --quiet --yes \
    'tensorflow=1.5*' \
    'keras=2.1*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


USER root
# INSTALL THEANOS
RUN apt-get update && apt-get install -y \
  build-essential \
  gfortran \
  git \
  wget \
  liblapack-dev \
  libopenblas-dev \
  python-dev \
  python-pip \
  python-nose \
  python-numpy \
  python-scipy

# Install bleeding-edge Theano
RUN pip install --upgrade pip && \
    pip install --upgrade six && \
    pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git

# Install gcc xgboost
RUN pip install xgboost

USER root
RUN pip install py4j==0.10.6 psutil
RUN pip install sos
RUN pip install sos-notebook
RUN python -m sos_notebook.install

RUN pip install markdown-kernel  
#USER root
USER $NB_UID
#python custom
ENV CUSTOM_DIR="$HOME/.custom"

# VOLUME $CUSTOM_DIR
RUN mkdir $CUSTOM_DIR
ENV PIP_TARGET=$CUSTOM_DIR/python3
RUN mkdir $PIP_TARGET
ENV PYTHONPATH=$PIP_TARGET:$PYTHONPATH

#r custom
 
RUN mkdir $CUSTOM_DIR/R
ENV R_LIBS_USER=$CUSTOM_DIR/R:$R_LIBS_USER

#julia custom
RUN mkdir -p $CUSTOM_DIR/julia
#RUN ln -s $CUSTOM_DIR/julia/v0.6/REQUIRE $JULIA_PKGDIR/v0.6 

ENV JULIA_LOAD_PATH=$JULIA_PKGDIR/v0.6
ENV JULIA_PKGDIR=$CUSTOM_DIR/julia

RUN julia -e 'Pkg.init()'

RUN pip install h2o_pysparkling_2.3 h2o

# RUN mkdir -p $HOME/.pip/ && touch  $HOME/.pip/pip.ini && echo "ignore-installed=true" >> $HOME/.pip/pip.ini 
# ENV PIP_CONFIG_FILE=$HOME/.pip/pip.ini


# USER $NB_UID
# #RSTUDIO
# ARG RSTUDIO_VERSION
# ENV PATH=/usr/lib/rstudio-server/bin:$PATH

# USER root
# ## Download and install RStudio server & dependencies
# ## Attempts to get detect latest version, otherwise falls back to version given in $VER
# ## Symlink pandoc, pandoc-citeproc so they are available system-wide
# RUN apt-get update \
#   && apt-get install -y --no-install-recommends \
#     file \
#     git \
#     libapparmor1 \
#     libcurl4-openssl-dev \
#     libedit2 \
#     libssl-dev \
#     lsb-release \
#     psmisc \
#     python-setuptools \
#     sudo \
#     wget \
#   && wget -O libssl1.0.0.deb http://ftp.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb \
#   && dpkg -i libssl1.0.0.deb \
#   && rm libssl1.0.0.deb \
#   && RSTUDIO_LATEST=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) \
#   && [ -z "$RSTUDIO_VERSION" ] && RSTUDIO_VERSION=$RSTUDIO_LATEST || true \
#   && wget -q http://download2.rstudio.org/rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
#   && dpkg -i rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
#   && rm rstudio-server-*-amd64.deb \
#   ## Symlink pandoc & standard pandoc templates for use system-wide
#   && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin \
#   && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin \
#   && git clone https://github.com/jgm/pandoc-templates \
#   && mkdir -p /opt/pandoc/templates \
#   && cp -r pandoc-templates*/* /opt/pandoc/templates && rm -rf pandoc-templates* \
#   && mkdir /root/.pandoc && ln -s /opt/pandoc/templates /root/.pandoc/templates \
#   && apt-get clean \
#   && rm -rf /var/lib/apt/lists/ \
#   ## RStudio wants an /etc/R, will populate from $R_HOME/etc
#   && mkdir -p /etc/R \
#   ## Write config files in $R_HOME/etc
#   ## && echo '\n\
#    ## \n# Configure httr to perform out-of-band authentication if HTTR_LOCALHOST \
#    ## \n# is not set since a redirect to localhost may not work depending upon \
#    ## \n# where this Docker container is running. \
#   ##  \nif(is.na(Sys.getenv("HTTR_LOCALHOST", unset=NA))) { \
#   ##  \n  options(httr_oob_default = TRUE) \
#   ##  \n}' >> $SPARK_HOME/R/etc/Rprofile.site \
#   ## && echo "PATH=${PATH}" >> $SPARK_HOME/etc/Renviron \
#   ## Need to configure non-root user for RStudio
#   && useradd rstudio \
#   && echo "rstudio:rstudio" | chpasswd \
#     && mkdir /home/rstudio \
#     && chown rstudio:rstudio /home/rstudio \
#     && addgroup rstudio staff \
#   ## Prevent rstudio from deciding to use /usr/bin/R if a user apt-get installs a package
#   &&  echo 'rsession-which-r=/usr/local/bin/R' >> /etc/rstudio/rserver.conf \
#   ## use more robust file locking to avoid errors when using shared volumes:
#   && echo 'lock-type=advisory' >> /etc/rstudio/file-locks \ 
#   ## configure git not to request password each time 
#   && git config --system credential.helper 'cache --timeout=3600' \
#   && git config --system push.default simple \
#   ## Set up S6 init system
#   && wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz \
#   && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
#   && mkdir -p /etc/services.d/rstudio \
#   && echo '#!/usr/bin/with-contenv bash \
#           \n exec /usr/lib/rstudio-server/bin/rserver --server-daemonize 0' \
#           > /etc/services.d/rstudio/run \
#   && echo '#!/bin/bash \
#           \n rstudio-server stop' \
#           > /etc/services.d/rstudio/finish \ 
#   && mkdir -p /home/rstudio/.rstudio/monitored/user-settings \ 
#   && echo 'alwaysSaveHistory="0" \ 
#           \nloadRData="0" \
#           \nsaveAction="0"' \ 
#           > /home/rstudio/.rstudio/monitored/user-settings/user-settings \ 
#   && chown -R rstudio:rstudio /home/rstudio/.rstudio

# COPY userconf.sh /etc/cont-init.d/userconf

# ## running with "-e ADD=shiny" adds shiny server
# COPY add_shiny.sh /etc/cont-init.d/add

# COPY pam-helper.sh /usr/lib/rstudio-server/bin/pam-helper

# EXPOSE 8787


# CMD ["/init"]