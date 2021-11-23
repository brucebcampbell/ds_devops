



#Jupyter
cd $HOME
mkdir certs
cd certs

conda install -y jupyter nbconvert jupyterthemes ipykernel

pip install jupyterlab
jupyter labextension install @jupyter-widgets/jupyterlab-manager

pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install --user
conda install -y -c conda-forge jupyterthemes
conda install -y -c conda-forge jupyter_contrib_nbextensions
conda install -y -c conda-forge jupyter_nbextensions_configurator

pip3 install jupyter-tabnine

pip install qgrid

jupyter nbextension enable --py widgetsnbextension
jupyter nbextension enable --py --sys-prefix qgrid
jupyter nbextension install --py jupyter_tabnine
jupyter nbextension enable --py jupyter_tabnine
jupyter serverextension enable --py jupyter_tabnine

openssl req -x509 -nodes -days 365 -newkey rsa:1024 -subj "/C=US/ST=IL/L=Chicago" -keyout mycert.pem -out mycert.pem
jupyter notebook --generate-config
JUPYTER_CONFIG='/home/wavescholar/.jupyter/jupyter_notebook_config.py'

echo "c = get_config()">>$JUPYTER_CONFIG
echo "# Notebook config this is where you saved your pem cert">>$JUPYTER_CONFIG
echo "c.NotebookApp.certfile = u'/home/wavescholar/certs/mycert.pem'">>$JUPYTER_CONFIG
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
