# Force Field and bond parameter 
## methane
### gmx rerun
```diff
gmx grompp -c methane.gro -p methane.top -f nvt.mdp -o nvt.tpr
gmx mdrun -rerun methane.gro -deffnm nvt
```
Check the potential energy at the end of the nvt.log file  
  
### bond parameter
```d
[ bonds ]
;    ai     aj funct        c0         c1         c2         c3
      1      2     1   0.10969 276646.080000
      1      3     1   0.10969 276646.080000
      1      4     1   0.10969 276646.080000
      1      5     1   0.10969 276646.080000
```