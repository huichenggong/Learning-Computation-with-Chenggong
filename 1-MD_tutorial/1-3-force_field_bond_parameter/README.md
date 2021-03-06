# Force Field and bond parameter 
## methane
### gmx rerun
```bash
gmx grompp -c methane.gro -p methane.top -f nvt.mdp -o nvt.tpr
gmx mdrun -rerun methane.gro -deffnm nvt
```
Check the potential energy at the end of the nvt.log file  
    
### bond parameter in "methane.top"
![\Large V_{bond}=\frac{1}{2} * k_b * (r-b_0)^2](https://latex.codecogs.com/svg.latex?\Large&space;V_{bond}=\frac{1}{2}*k_b*(r-b_0)^2)   
A reminder of the unit    
b<sub>0</sub> (nm)  
k<sub>b</sub> (kJ mol<sup>−1</sup>nm<sup>−2</sup>)
```
[ bonds ]
;    ai     aj funct        b0      kb
      1      2     1   0.10969 276646.080000
      1      3     1   0.10969 276646.080000
      1      4     1   0.10969 276646.080000
      1      5     1   0.10969 276646.080000
```
    
### angle parameter in "methane.top"
![V_{bond}=\frac{1}{2}*k_b*(r-b_0)^2](https://latex.codecogs.com/svg.latex?\Large&space;V_{bond}=\frac{1}{2}*k_b*(r-b_0)^2)   
A reminder of the unit  
θ<sub>0</sub> (deg)  
k<sub>θ</sub> (kJ mol<sup>−1</sup>rad<sup>−2</sup>)
```
[ angles ]
;    ai     aj     ak funct     theta_0    k_theta 
      2      1      3     1   107.5800459 329.699200
      2      1      4     1   107.5800459 329.699200
      2      1      5     1   107.5800459 329.699200
      3      1      4     1   107.5800459 329.699200
      3      1      5     1   107.5800459 329.699200
      4      1      5     1   107.5800459 329.699200
```
Please check [gromacs manual](https://manual.gromacs.org/documentation/current/reference-manual/topologies/topology-file-formats.html) for more detail.  
