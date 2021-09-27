# prepare top
## protein
```
gmx pdb2gmx -f 3HTB_clean_pro.pdb -o 3HTB_01.gro
```
## ligand

## complex
```
gmx editconf -f TOP/3HTB_02_complex.gro -o 3HTB_03_box.gro -bt dodecahedron -d 1.0
gmx solvate -cp 3HTB_03_box.gro -cs spc216.gro -p TOP/topol.top -o 3HTB_04_solv.gro
gmx grompp -f 1-em/minim-NoRes.mdp -c 3HTB_04_solv.gro -p TOP/topol.top -o ions -maxwarn 1
gmx genion -s ions.tpr -o 3HTB_05_ion.gro -p TOP/topol.top -pname NA -nname CL -neutral
```
# MD run
## Minimization
1. minimization with 500 kJ/(mol*A^2) restrain  
```
gmx grompp -f minim-FC-500.mdp -c ../3HTB_05_ion.gro -r ../3HTB_05_ion.gro  -p ../TOP/topol.top -o em1.tpr
gmx mdrun -v -deffnm em1
gmx energy -f em1.edr -o em1_potential.xvg
```

2. minimization with no restrain  
```
gmx grompp -f minim-NoRes.mdp   -c em1.gro  -r em1.gro   -p ../TOP/topol.top -o em2.tpr
gmx mdrun -v -deffnm em2
```

## nvt
1. nvt 100ps with 500 kJ/(mol*A^2) restrain  
```
gmx grompp -f nvt.mdp -c ../1-em/em2.gro -r ../1-em/em2.gro -p ../TOP/topol.top -o nvt.tpr
gmx mdrun -v -deffnm nvt
```
2. checking temperature
```
gmx energy -f nvt.edr -o temperature.xvg
```
## NPT1
1. npt with 500 kJ/(mol*A^2) restrain
```
gmx grompp -f npt.mdp -c ../2-nvt/nvt.gro -r ../1-em/em2.gro -t ../2-nvt/nvt.cpt -p ../TOP/topol.top -o npt.tpr
gmx mdrun -v -deffnm npt
```
2. checking temperature
```
gmx energy -f npt.edr -o temperature.xvg
```
3. checking density
```
gmx energy -f npt.edr -o density
```
## NPT2  
1. npt with no restrain
```
gmx grompp -f npt.mdp -c ../3-npt/npt.gro -r ../1-em/em2.gro -t ../3-npt/npt.cpt -p ../TOP/topol.top -o npt.tpr
gmx mdrun -v -deffnm npt
```
2. VMD visual check  