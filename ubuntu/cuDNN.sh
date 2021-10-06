
wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.2.4/11.4_20210831/Ubuntu20_04-x64/libcudnn8_8.2.4.15-1+cuda11.4_amd64.deb

wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.2.4/11.4_20210831/Ubuntu20_04-x64/libcudnn8-dev_8.2.4.15-1+cuda11.4_amd64.deb

wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.2.4/11.4_20210831/Ubuntu20_04-x64/libcudnn8-samples_8.2.4.15-1+cuda11.4_amd64.deb

sudo dpkg -i libcudnn8_8.2.4.15-1+cuda11.4_amd64.deb

#update-alternatives: using /usr/include/x86_64-linux-gnu/cudnn_v8.h to provide /usr/include/cudnn.h (libcudnn) in auto mode
#This might need config if we installed the runtime first?
sudo dpkg -i libcudnn8-dev_8.2.4.15-1+cuda11.4_amd64.deb

#Pretty Sure you can't install this unless you have the developer library
sudo dpkg -i libcudnn8-samples_8.2.4.15-1+cuda11.4_amd64.deb
