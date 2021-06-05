cmake ../gromacs-2021.2 \  
  -DGMX_BUILD_OWN_FFTW=ON \  
  -DREGRESSIONTEST_DOWNLOAD=OFF \  
  -DREGRESSIONTEST_PATH=../regressiontests-2021.2 \  
  -DCMAKE_C_COMPILER=gcc \  
  -DGMX_GPU=CUDA \  
  -DCMAKE_INSTALL_PREFIX=~/Software/GMX/2021.2-cuda
#change the INSTALL_PREFIX according to your need
