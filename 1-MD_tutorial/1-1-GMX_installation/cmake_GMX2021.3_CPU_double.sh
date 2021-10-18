mkdir build-icc-double  
cd build-icc-double  
pwd
cmake ../gromacs-2021.3 \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DREGRESSIONTEST_DOWNLOAD=OFF \
  -DREGRESSIONTEST_PATH=../regressiontests-2021.3 \
  -DCMAKE_C_COMPILER=icc \
  -DCMAKE_CXX_COMPILER=icpc \
  -DGMX_DOUBLE=on \
  -DCMAKE_INSTALL_PREFIX=~/Software/GMX/2021.3-icc-double  
#change the INSTALL_PREFIX according to your need
