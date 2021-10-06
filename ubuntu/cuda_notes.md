# CUDA Notes

## Do I have a GPU?

Check  NVIDIA GPU. Open your terminal and run the below command.
```
sudo lshw -C display
```

## Cleanup Old Drivers First

Uninstall/remove/revert all CUDA-related changes you have made to the system so far! The following commands should do that for you:

```
sudo rm /etc/apt/sources.list.d/cuda*
sudo apt remove --autoremove nvidia-*
sudo apt-get purge nvidia*
sudo apt-get autoclean
sudo apt-get autoremove
sudo rm -rf /usr/lib/cuda*
sudo rm -rf /usr/local/cuda*
```

Remove CUDA paths (usually appended at the end between ifand fi) from .profile and .bashrc files and save them.

```
sudo gedit ~/.profile
sudo source ~/.profile
sudo gedit ~/.bashrc
sudo source ~/.bashrc
```

Once removed, echo $PATH | grep cudaand echo $LD_LIBRARY_PATH | grep cudashould not have ‘cuda’ in it!
Now we will tidy up python packages. If you have any python virtual environments set up (read here), you should switch to them. But for my setup, I ran this single command:
pip uninstall tb-nightly tensorboardX tensorboard tensorflow tensorflow-gpu
This might throw some errors depending upon whether you had that package installed or not so no need to worry!

What's the difference between CUDA and CUDA Toolkit?

CUDA Toolkit is a software package that has different components. The main pieces are: CUDA SDK (The compiler, NVCC, libraries for developing CUDA software, and CUDA samples) GUI Tools (such as Eclipse Nsight for Linux/OS X or Visual Studio Nsight for Windows) This link provides the information to deduce the right versions of CUDA and the CUDA Toolkit;
https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html


Before installing drivers and toolkits we need to decide what libraries will be calling into CUDA and what versions they support. AS of 100321 the correct version of CUDA for Tensorflow is 11.2 but the latest drivers are at 11.4. This means you cannot use the latest drivers with the latest release of Tensorflow. Worse - what if you need Pytorch *and* tensorflow and they have different requirements for CUDA version? The latest version of Pytorch supports


From this entry `CUDA 11.2.2 Update 2	>=460.32.03	>=461.33` we see that we should set up driver version 460

## CUDA Toolkit

https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local

```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.4.2/local_installers/cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-4-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda

```

## HPC Library - has nvfortran

```
wget https://developer.download.nvidia.com/hpc-sdk/21.9/nvhpc-21-9_21.9_amd64.deb
wget https://developer.download.nvidia.com/hpc-sdk/21.9/nvhpc-2021_21.9_amd64.deb
sudo apt-get install ./nvhpc-21-9_21.9_amd64.deb ./nvhpc-2021_21.9_amd64.deb
```

confusion regarding NVIDIA’s nvcc sm flags and what they’re used for:
When compiling with NVCC, the arch flag (‘-arch‘) specifies the name of the NVIDIA GPU architecture that the CUDA files will be compiled for.
Gencodes (‘-gencode‘) allows for more PTX generations and can be repeated many times for different architectures.

Here’s a list of NVIDIA architecture names, and which compute capabilities they have:

Fermi†	Kepler†	Maxwell‡	Pascal	Volta	Turing	Ampere	Lovelace*	Hopper**
sm_20	sm_30	sm_50	sm_60	sm_70	sm_75	sm_80	sm_90?	sm_100c?
      sm_35	sm_52	sm_61	sm_72		sm_86		
      sm_37	sm_53	sm_62				

GeForce RTX™ 3080 Ti and RTX 3080 graphics cards are on Ampere; NVIDIA's 2nd gen RTX architecture


## See what cuda drivers are loaded


```
lsmod | grep nvidia
```

nvidia_uvm           1048576  2
nvidia_drm             61440  10
nvidia_modeset       1196032  20 nvidia_drm
nvidia              35270656  1381 nvidia_uvm,nvidia_modeset
drm_kms_helper        245760  1 nvidia_drm
drm                   552960  14 drm_kms_helper,nvidia,nvidia_drm
