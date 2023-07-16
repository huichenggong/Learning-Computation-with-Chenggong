#!/bin/bash
eval "$(conda shell.bash hook)"

conda activate mda

cd 01-mdtraj
echo -e "\n# mdtraj"
time ./distance_iter.py
cd ../

cd 02-mdanalysis
echo -e "\n# mdanalysis"
rm ../../data/.fix_atom_c_40ps.xtc_offsets.*
time ./distance_iter.py
cd ../

conda deactivate

conda activate pytraj

cd 03-pytraj
echo -e "\n# pytraj"
time ./distance_iter.py
cd ../

conda deactivate

cd 04-GMX_distance
echo -e "\n# gmx distance"
time ./distance.sh > /dev/null 2>&1
cd ../

cd 05-GMXLIB_CPP
echo -e "\n# gmxlib cpp"
time ./build/dist > distance.csv
cd ../
