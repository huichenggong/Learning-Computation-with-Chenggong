# Gaussian+Antechamber+acpype for non standard residue GAFF parameterization  

## Gaussian parameter explanation
```
# opt b3lyp/6-31g(d) scrf=(smd,solvent=water) pop=mk geom=connectivity iop(6/33=2,6/42=6)
```
opt:  
optimization  

b3lyp/6-31g(d):  
B3lyp dft functional with 6-31g basis set and polarization for heavy atom  

scrf=(smd,solvent=water):  
smd implicit water model  

pop=mk:  
output Merz-Kollman (ESP) charges  

geom=connectivity  
connectivity (bond) will be read from input  

iop
6/42=6  
6 points per unit area in esp fit. Please check [Gaussian manual](https://gaussian.com/overlay6/#iop_(6/42)) for more detail  

6/33=2  
makes Gaussian write out the potential points and the potentials  

## Run Gaussian optimization
```bash
g16 jz4.gjf
```
This will write jz4.log as output.  

## Antechamber
```bash
antechamber -i jz4.log -fi gout -o jz4.mol2 -fo mol2 -c resp
```

-i input file name  
-fi input file format  
-o output file name  
-fo output file format  
-c charge method  

## Run parmchk to add missing parameter
```bash
parmchk2 -i jz4.mol2 -f mol2 -o jz4.frcmod
```
-i input file name  
-f input file format (prepi, prepc, ac, mol2, frcmod, leaplog)  
-o frcmod file name  
-s ff parm set, it is suppressed by "-p" option  
 1 or gaff:    gaff (the default)  
 2 or gaff2:   gaff2  
 3 or parm99:  parm99  
 4 or parm10:  parm10  
 5 or lipid14: lipid14  

## Run tleap to prepare prmtop
```bash
tleap
```
```tleap
source leaprc.gaff
jz4=loadmol2 jz4.mol2
loadamberparams jz4.frcmod
saveamberparm jz4 test.prmtop test.rst7
```

## acpype for converting amber to gromacs
```
acpype -p test.prmtop -x test.rst7
```