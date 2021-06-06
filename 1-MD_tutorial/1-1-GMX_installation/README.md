# GMX installation  
## GMX Version 2021.2  
### \# Install pre-request  
```diff
sudo apt install build-essential cmake
``` 
### \# check system  
```diff
# check gcc compiler
gcc --version
# check CPU information, such as SIMD
lscpu
# check nvidia driver
nvidia-smi
```
### \# Download package
```diff
wget https://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz
wget https://ftp.gromacs.org/regressiontests/regressiontests-2021.2.tar.gz
tar -xvzf gromacs-2021.2.tar.gz
tar -xvzf regressiontests-2021.2.tar.gz
```
### \# cmake when you have GPU with proper driver/cuda  
```diff
mkdir build-001
cd build-001
cmake ../gromacs-2021.2 \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DREGRESSIONTEST_DOWNLOAD=OFF \
  -DREGRESSIONTEST_PATH=../regressiontests-2021.2 \
  -DCMAKE_C_COMPILER=gcc \
  -DGMX_GPU=CUDA \
  -DCMAKE_INSTALL_PREFIX=~/Software/GMX/2021.2-cuda
#change the INSTALL_PREFIX according to your need
```
### \# cmake CPU version
```diff
mkdir build-001
cd build-001
cmake ../gromacs-2021.2 \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DREGRESSIONTEST_DOWNLOAD=OFF \
  -DREGRESSIONTEST_PATH=../regressiontests-2021.2 \
  -DCMAKE_C_COMPILER=gcc \
  -DCMAKE_INSTALL_PREFIX=~/Software/GMX/2021.2-CPU2
#change the INSTALL_PREFIX according to your need
```
### \# build - test - install
```diff
make -j 4 #4 cores will be used here, you can use more
make check
make install
```
