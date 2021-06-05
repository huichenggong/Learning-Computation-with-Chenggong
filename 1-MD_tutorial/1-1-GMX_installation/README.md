## GMX installation  
### \# Install pre-request
sudo apt install build-essential  
sudo apt install cmake  
    
### \# check gcc  
gcc --version
### \# check CPU
lscpu

### \# Download package
wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz  
wget https://ftp.gromacs.org/regressiontests/regressiontests-2021.2.tar.gz  
tar -xvzf gromacs-2021.2.tar.gz  
tar -xvzf regressiontests-2021.2.tar.gz  

### \# cmake
mkdir build-001  
cd build-001  
cmake ../gromacs-2021.2&nbsp; \\  
&ensp;-DGMX_BUILD_OWN_FFTW=ON&nbsp; \\  
&ensp;-DREGRESSIONTEST_DOWNLOAD=OFF \\  
&ensp;-DREGRESSIONTEST_PATH=../regressiontests-2021.2&nbsp; \\  
&ensp;-DCMAKE_C_COMPILER=gcc&nbsp; \\  
&ensp;-DCMAKE_INSTALL_PREFIX=~/Software/GMX/2021.2-CPU2  
