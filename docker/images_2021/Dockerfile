FROM ubuntu:18.04
 
## copied from Domino support@dominodatalab.com
LABEL maintainer="Donald Chesworth <dcheswor@redhat.com>"
 
#### Utilities required by Domino ####
ENV DEBIAN_FRONTEND noninteractive
 
#create a Ubuntu User
RUN \
  groupadd -g 12574 ubuntu && \
  useradd -u 12574 -g 12574 -m -N -s /bin/bash ubuntu && \
  # UPDATE, UPGRADE, ADD repositories
  apt-get update -y && \
  apt-get -y install software-properties-common && \
  apt-get -y upgrade && \
  # CONFIGURE locales
  apt-get install -y locales && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  # INSTALL common
  apt-get -y install build-essential wget sudo curl apt-utils net-tools libzmq3-dev ed git ca-certificates iputils-ping dnsutils telnet apt-transport-https vim python3-pip jq zip && \
  apt-get install openjdk-8-jdk -y && \
  update-alternatives --config java && \
  echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/ubuntu/.domino-defaults && \
  apt-get -y --no-install-recommends install libssl-dev libxml2-dev libxt-dev libssh2-1-dev libcurl4-openssl-dev libsasl2-dev libssl-dev && \
  #apt AWS CLI
  apt-get install awscli -y  && \
  # ADD SSH start script for ssh'ing to run container in Domino <v4.0
  apt-get install openssh-server -y && \
  mkdir -p /scripts && \
  printf "#!/bin/bash\\nservice ssh start\\n" > /scripts/start-ssh && \
  chmod +x /scripts/start-ssh && \
  # EXPORTS
  echo 'export PYTHONIOENCODING=utf-8' >> /home/ubuntu/.domino-defaults && \
  echo 'export LANG=en_US.UTF-8' >> /home/ubuntu/.domino-defaults && \
  echo 'export JOBLIB_TEMP_FOLDER=/tmp' >> /home/ubuntu/.domino-defaults && \
  echo 'export LC_ALL=en_US.UTF-8' >> /home/ubuntu/.domino-defaults && \
  locale-gen en_US.UTF-8 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
 
ENV LANG en_US.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
 
 
######Install Python 3.7 and Miniconda######
#Inspriration: https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
 
# https://repo.continuum.io/miniconda/
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
# Install conda as jovyan and check the md5 sum provided on the download site
ENV MINICONDA_VERSION=4.8.3 \
    MINICONDA_MD5=751786b92c00b1aeae3f017b781018df \
    CONDA_VERSION=4.8.3
ENV PYTHON_MAJOR 3
ENV PYTHON_MINOR 7
ENV PYTHON_VER $PYTHON_MAJOR.$PYTHON_MINOR
ENV MINICONDA_SH Miniconda3-py$PYTHON_MAJOR${PYTHON_MINOR}_${MINICONDA_VERSION}-Linux-x86_64.sh
 
#set env variables so they are available in Domino runs/workspaces
RUN \
    echo 'export CONDA_DIR=/opt/conda' >> /home/ubuntu/.domino-defaults && \
    echo 'export PATH=$CONDA_DIR/bin:$PATH' >> /home/ubuntu/.domino-defaults && \
    echo 'export PATH=/home/ubuntu/.local/bin:$PATH' >> /home/ubuntu/.domino-defaults
 
#Install Python and Mini-conda
WORKDIR /tmp
RUN wget --quiet https://repo.continuum.io/miniconda/$MINICONDA_SH && \
    echo "${MINICONDA_MD5} *$MINICONDA_SH" | md5sum -c - && \
    /bin/bash $MINICONDA_SH -f -b -p $CONDA_DIR && \
    rm $MINICONDA_SH && \
# Specify the python version
    conda install python=${PYTHON_VER} && \
# make conda folder permissioned for ubuntu user
    chown ubuntu:ubuntu -R $CONDA_DIR && \
# Use Mini-conda's pip
    ln -s $CONDA_DIR/bin/pip /usr/bin/pip && \
# Use Mini-conda's python
    ln -s $CONDA_DIR/bin/python /usr/local/bin/python && \
    ln -s $CONDA_DIR/anaconda/bin/python /usr/local/bin/python3  && \
#Set permissions
    chown -R ubuntu:ubuntu  $CONDA_DIR && \
#Upgrade Pip
    pip install --upgrade pip && \
 
#Add various package dependencies and useful libraries
    apt-get update && \
    apt-get install -y --no-install-recommends libhdf5-dev libyaml-dev pkg-config libfuse-dev cups libcups2-dev python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 python-mvpa2 libsmbclient-dev libcups2-dev python-debian python-igraph swig  && \
 
###Install Domino Dependencies ####
#packages used for model APIs and Apps
    $CONDA_DIR/bin/conda install -c conda-forge uWSGI==2.0.18 && \
    pip install Flask==1.0.2 Flask-Compress==1.4.0 Flask-Cors==3.0.6 jsonify==0.5 && \
 
### Install packages used in Domino quick-start project
    pip install git+https://github.com/dominodatalab/python-domino.git
 
## DOC removed all the additional package installs, and sticking with miniconda
RUN pip install \
  tensorflow-gpu==2.2.1
 
#Kerberos
RUN \
    apt-get install krb5-kdc krb5-admin-server -y && \
#clean up
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    $CONDA_DIR/bin/conda clean -afy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -Rf /tmp/*
 
#### Installing Notebooks,Workspaces,IDEs,etc ####
# Add workspace install and configuration scripts
RUN \
    cd /tmp && \
    wget -q https://github.com/dominodatalab/workspace-configs/archive/2020q1-v4.zip && \
    unzip 2020q1-v4.zip && \
    cp -Rf workspace-configs-2020q1-v4/. /var/opt/workspaces && \
    rm -rf /var/opt/workspaces/workspace-logos && rm -rf /tmp/workspace-configs-2020q1-v4 && \
 
# # # # #Install Jupyter from workspaces
    chmod +x /var/opt/workspaces/jupyter/install && \
    /var/opt/workspaces/jupyter/install && \
 
# # # # #Install vscode from workspaces
#Required for VSCode
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
    apt-get update && \
    apt-get install --no-install-recommends libssl1.0-dev node-gyp nodejs -y && \
    pip install python-language-server autopep8 flake8 pylint && \
    pip install git+git://github.com/dominodatalab/jupyter_codeserver_proxy-.git && \
#Install VScode
    chmod +x /var/opt/workspaces/vscode/install && \
    /var/opt/workspaces/vscode/install && \
 
# # # # #nstall Jupyterlab from workspaces
    chmod +x /var/opt/workspaces/Jupyterlab/install && \
    /var/opt/workspaces/Jupyterlab/install && \
# Adding jupyter-server-proxy for jupyter and jupyterlab
    pip install jupyter-server-proxy && \
    jupyter labextension install @jupyterlab/server-proxy && \
#   chown -R ubuntu:ubuntu /home/ubuntu/.config
 
#Clean up
    rm -rf /var/lib/apt/lists/* && \
    rm -Rf /tmp/* && \
#set permissions
    chown -R ubuntu:ubuntu /home/ubuntu/.local/
 
 
#### Install CUDA and GPU dependencies #####
 
###Install CUDA Base###
ENV CUDA_VERSION 11.0.3
ENV CUDA_MAJOR 11.0
#### cuda component versions are no longer the same
#ENV CUDART 11.0.221
#ENV CUDART_VERSION 11-0=$CUDART-1
ENV CUDA_PKG_VERSION 11-0
 
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends gnupg2 ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
 
# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
    apt-get update && \
    apt-get install -y --no-install-recommends cuda-cudart-$CUDA_PKG_VERSION cuda-compat-$CUDA_PKG_VERSION && \
    ln -s cuda-$CUDA_MAJOR /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*
 
# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=$CUDA_MAJOR brand=tesla,driver>=450,driver<455"
 
### CUDA RUNTIME ###
ENV NCCL_VERSION 2.7.8
ENV NCCL_MAJOR 2
 
RUN \
    apt-get update && apt-get install -y --no-install-recommends cuda-libraries-$CUDA_PKG_VERSION cuda-nvtx-$CUDA_PKG_VERSION libnccl$NCCL_MAJOR=$NCCL_VERSION-1+cuda$CUDA_MAJOR && \
    apt-mark hold libnccl$NCCL_MAJOR && \
    rm -rf /var/lib/apt/lists/*
 
###Install CUDNN###
 
ENV CUDNN_VERSION 8.0.2.39
ENV CUDNN_MAJOR 8
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"
 
RUN \
   apt-get update && apt-get install -y --no-install-recommends libcudnn$CUDNN_MAJOR=$CUDNN_VERSION-1+cuda$CUDA_MAJOR && \
   apt-mark hold libcudnn$CUDNN_MAJOR && \
   rm -rf /var/lib/apt/lists/*
 
RUN \
   export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/nvidia/lib:/usr/local/nvidia/lib64:\${LD_LIBRARY_PATH:-} && \
   echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/nvidia/lib:/usr/local/nvidia/lib64:\${LD_LIBRARY_PATH:-}" >> /home/ubuntu/.domino-defaults && \
 
   export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:\${PATH:-} && \
   echo "export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:\${PATH:-}" >> /home/ubuntu/.domino-defaults
 
# DOC need psycopg2 and cmake
RUN \
  pip install psycopg2-binary && \
  apt-get update && apt-get install -y --no-install-recommends libpq-dev
 
RUN conda install -c anaconda cmake
 
#Provide Sudo in container
RUN echo "ubuntu    ALL=NOPASSWD: ALL" >> /etc/sudoers
