

Check  NVIDIA GPU. Open your terminal and run the below command.
```
sudo lshw -C display
```

What's the difference between CUDA and CUDA Toolkit?

CUDA Toolkit is a software package that has different components. The main pieces are: CUDA SDK (The compiler, NVCC, libraries for developing CUDA software, and CUDA samples) GUI Tools (such as Eclipse Nsight for Linux/OS X or Visual Studio Nsight for Windows) This link provides the information to deduce the right versions of CUDA and the CUDA Toolkit;
https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html


Before installing drivers and toolkits we need to decide what libraries will be calling into CUDA and what versions they support. AS of 100321 the correct version of CUDA for Tensorflow is 11.2 but the latest drivers are at 11.4. This means you cannot use the latest drivers with the latest release of Tensorflow. Worse - what if you need Pytorch *and* tensorflow and they have different requirements for CUDA version? The latest version of Pytorch supports


From this entry `CUDA 11.2.2 Update 2	>=460.32.03	>=461.33` we see that we should set up  
