mkdir build-gcc-cuda
cd build-gcc-cuda
pwd
cmake ../gromacs-2021.3 \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DREGRESSIONTEST_DOWNLOAD=OFF \
  -DREGRESSIONTEST_PATH=../regressiontests-2021.3 \
  -DCMAKE_C_COMPILER=gcc \
  -DGMX_GPU=CUDA \
  -DCMAKE_INSTALL_PREFIX=~/Software/GMX/2021.3-gcc-cuda
  