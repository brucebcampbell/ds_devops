#sudo apt update && sudo apt upgrade -y
sudo apt-get update

sudo apt-get -y install git-all
sudo apt-get -y install build-essential
sudo apt-get -y install make
sudo apt-get -y install libtool m4 automake
sudo apt-get -y install autoconf
sudo apt-get -y install tmux
sudo apt-get -y install texlive-*

wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
bash Anaconda3-2021.05-Linux-x86_64.sh

echo "ready"
#LOGOUT AND BACK IN
conda upgrade -y setuptools
conda remove -y --name snowflakes --all
conda create -y -n snowflakes python=3.8
conda activate snowflakes

conda install -y pip
conda install -y Flake8 nbconvert sphinx ipywidgets
conda install -y tensorflow
pip install --upgrade tensorflow-probability
conda install -y IPython Cython
conda install -y keras
conda install -y pandas pandas-profiling
conda install -y -c quantopian pandas-datareader #The Pandas datareader is a sub package that allows one to create a dataframe from various internet datasources, currently including:Yahoo! FinanceGoogle FinanceSt.Louis FED (FRED)Kenneth French’s data libraryWorld BankGoogle Analytics
conda install -y matplotlib seaborn pyviz datashader altair
conda install -y numpy scipy scikit-learn
conda install -y dill #dill extends python’s pickle module for serializing and de-serializing python objects to the majority of the built-in python types. Serialization is the process of converting an object to a byte stream, and the inverse of which is converting a byte stream back to a python object hierarchy.

conda install -n snowflakes -c rapidsai -c nvidia -c conda-forge blazingsql=0.19 cudf=0.19 python=3.8 cudatoolkit=10.1
pip install --ignore-installed great-expectations
pip install 'ray[default]' xgboost_ray
pip install umap-learn
pip install Optuna
pip install lightgbm catboost category_encoders
pip install tsfresh prophet orbit-ml
pip install --upgrade jax jaxlib==0.1.67+cuda111 -f https://storage.googleapis.com/jax-releases/jax_releases.html
pip install numba
#  L1 and Convex Optimization
pip install  osqp
conda install -y cvxopt
#cvxpy module is a nice wrapper around cvxopt that follows paradigm of a disciplined convex programming.
conda install -y -c conda-forge lapack
conda install -y -c cvxgrp cvxpy
#https://pymanopt.github.io/
#Riemannian Optimisation with Pymanopt for Inference in MoG models
#https://pymanopt.github.io/MoG.html
pip install -y --user pymanopt
conda install -y -c conda-forge autograd

#PyEMD is a Python wrapper for Ofir Pele and Michael Werman's implementation of the Earth Mover's Distance that allows it to be used with NumPy
conda install -y pyemd
conda install -y -c conda-forge pot
pip install  dit

conda install -y pillow #Imaging - from PIL import Image

conda install -y pystan
conda install -y -c conda-forge google-cloud-storage


conda install -y gensim
conda install -y nltk
conda install -y spacy
python -m spacy download en
pip install pyLDAvis


#time-freq
git clone https://github.com/scikit-signal/pytftb
cd pytftb
pip install -r requirements.txt
python setup.py install
cd ~

git clone https://github.com/chokkan/liblbfgs.git
cd liblbfgs/
./autogen.sh
./configure
make
sudo make install
cd ~

git clone https://rtaylor@bitbucket.org/rtaylor/pylbfgs.git
cd pytftb/
python setup.py install

conda activate snowflakes

echo  '
conda activate snowflakes
'  >> ~/.bashrc


#Jupyter
cd $HOME
mkdir certs
cd certs
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -subj "/C=US/ST=IL/L=Chicago" -keyout mycert.pem -out mycert.pem
jupyter notebook --generate-config
JUPYTER_CONFIG='/home/bruce/.jupyter/jupyter_notebook_config.py'

conda install -y jupyter
conda install -y nbconvert
conda install -y -c conda-forge jupyter_contrib_nbextensions
conda install -y -c conda-forge jupyter_nbextensions_configurator

pip3 install jupyter-tabnine
jupyter nbextension install --py jupyter_tabnine
jupyter nbextension enable --py jupyter_tabnine
jupyter serverextension enable --py jupyter_tabnine

echo "c = get_config()">>$JUPYTER_CONFIG
echo "# Notebook config this is where you saved your pem cert">>$JUPYTER_CONFIG
echo "c.NotebookApp.certfile = u'/home/bruce/certs/mycert.pem'">>$JUPYTER_CONFIG
echo "# on all IP addresses of your instance">>$JUPYTER_CONFIG
echo "c.NotebookApp.ip = '*'">>$JUPYTER_CONFIG
echo "# Don't open browser by default">>$JUPYTER_CONFIG
echo "c.NotebookApp.open_browser = False">>$JUPYTER_CONFIG
echo "# Fix port to 8080">>$JUPYTER_CONFIG
echo "c.NotebookApp.port = 8080">>$JUPYTER_CONFIG
echo "c.NotebookApp.allow_remote_access = True">>$JUPYTER_CONFIG
cd $HOME
tmux
jupyter notebook &
