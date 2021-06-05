# Amber installation  
## Ambertools2021 Amber20  
### \# Install pre-request  
```diff
sudo apt install bc csh flex xorg-dev zlib1g-dev \
    libbz2-dev patch cmake bison gfortran python
``` 
### \# Download and Unzip files
https://ambermd.org/index.php
```diff
tar xvfj AmberTools21.tar.bz2 # Ambertools are open source
tar xvfj Amber20.tar.bz2      # only when you have amber
```

### \# Enter source code dir and cmake
\# When you have GPU with proper driver/cuda
```diff
cd amber20_src
./update_amber --upgrade
mkdir build-001
cd build-001
cmake ../ \
    -DCMAKE_INSTALL_PREFIX=~/Software/Amber20_cuda \
    -DCOMPILER=GNU  \
    -DMPI=FALSE -DCUDA=TRUE -DINSTALL_TESTS=TRUE \
    -DDOWNLOAD_MINICONDA=TRUE -DMINICONDA_USE_PY3=TRUE
```
\# CPU version
```diff
cd amber20_src
./update_amber --upgrade
mkdir build-001
cd build-001
cmake ../ \
    -DCMAKE_INSTALL_PREFIX=~/Software/Amber20_CPU \
    -DCOMPILER=GNU  \
    -DMPI=FALSE  -DINSTALL_TESTS=TRUE \
    -DDOWNLOAD_MINICONDA=TRUE -DMINICONDA_USE_PY3=TRUE
```
### \# make
```diff
make install -j 4 # 4 cores will be used, change accordingly
```
### \# Go to installation dir and test
\# Test GPU version
```diff
source ~/Software/Amber20_cuda/amber.sh 
cd ~/Software/Amber20_cuda
make test.cuda.serial
make test.serial
```
\# Test CPU version
```diff
source ~/Software/Amber20_CPU/amber.sh 
cd ~/Software/Amber20_CPU
make test.serial
```