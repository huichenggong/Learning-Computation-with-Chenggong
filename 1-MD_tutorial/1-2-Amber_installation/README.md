apt install bc csh flex xorg-dev zlib1g-dev \
    libbz2-dev patch cmake bison gfortran python
tar xvfj AmberTools20.tar.bz2 && tar xvfj Amber20.tar.bz2
cd amber20_src
./update_amber --upgrade
cmake ../ \
    -DCMAKE_INSTALL_PREFIX=/Software/Amber20_cuda \
    -DCOMPILER=GNU  \
    -DMPI=FALSE -DCUDA=TRUE -DINSTALL_TESTS=TRUE \
    -DDOWNLOAD_MINICONDA=TRUE -DMINICONDA_USE_PY3=TRUE
make install -j 16
#go to installation dir and test
cd /Software/Amber20_cuda
source /Software/Amber20_cuda/amber.sh
make test.cuda.serial
