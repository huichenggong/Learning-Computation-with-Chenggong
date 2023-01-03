mkdir build-001  
cd build-001  
cmake ../gromacs-2022.4 \  
  -DGMX_BUILD_OWN_FFTW=ON \  
  -DREGRESSIONTEST_DOWNLOAD=OFF \  
  -DREGRESSIONTEST_PATH=../regressiontests-2022.4 \  
  -DCMAKE_C_COMPILER=gcc \   
  -DCMAKE_INSTALL_PREFIX=~/Software/GMX/2022.4-CPU
#change the INSTALL_PREFIX according to your need
