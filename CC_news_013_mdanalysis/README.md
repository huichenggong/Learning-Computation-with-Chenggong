# MDAnalysis, mdtraj, pytraj  
## 1.Installation

### 1.1 For MDAnalysis and mdtraj  
```bash
conda create -n mda MDAnalysis mdtraj pandas -c conda-forge
```

### 1.2 For pytraj
```bash
conda create -n pytraj -c ambermd pytraj pandas
```
pytraj-linux only works with py3.5/3.6/3.7, pytraj-Mac only works with py3.5/3.6/3.7/3.8.    
See the [doc](https://anaconda.org/AmberMD/pytraj/)

### 1.3 Compile C++ code
Download and compile gromacs
```
cd speed_test_distance/05-GMXLIB_CPP/
mkdir build
cd build

source ~/Software/GMX/2022.5-cuda11.7-gcc11/bin/GMXRC
# This is where you installed gromacs.

cmake  ../ -DGROMACS_SRC_DIR=/home/cheng/Software/Package/GMX/2022.5/gromacs-2022.5
# This is the gromacs source code folder you downloaded.

make
```

### 1.X Remove conda environment
After all the tesing, if you don't want to keep those conda environment, do this.
```bash
conda remove -n Name_of_Env --all  # You need to deactivate before removing
```

## 2 Speed test
I only uploaded a short trajectory.
```bash
cd data/
mv fix_atom_c_40ps_short.xtc fix_atom_c_40ps.xtc
cd ../speed_test_distance/
./run_all.sh
```
Here is my test result with longer trajectory.
```
# mdtraj

real	0m27.473s
user	0m26.748s
sys	0m1.519s

# mdanalysis

real	0m16.301s
user	0m16.202s
sys	0m0.891s

# pytraj

real	0m15.856s
user	0m15.644s
sys	0m0.212s

# gmx distance

real	0m23.892s
user	0m23.755s
sys	0m0.136s

# gmxlib cpp

real	0m15.320s
user	0m15.159s
sys	0m0.160s

```
