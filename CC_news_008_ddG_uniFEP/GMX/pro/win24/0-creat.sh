#!/bin/bash



rm -rf Lambda*
rm -rf \#*
base=$PWD
top=../../../topol.top
for i in {0..24};
do

    mkdir  Lambda_$i
    mkdir Lambda_$i/EM
    mkdir Lambda_$i/NVT
    mkdir Lambda_$i/NPT
    mkdir Lambda_$i/MD
    awk '{print $0}' em.mdp >> Lambda_$i/EM/em.mdp
    printf "\n" >> Lambda_$i/EM/em.mdp
    printf "init-lambda-state        = $i" >> Lambda_$i/EM/em.mdp
    printf "\n" >> Lambda_$i/EM/em.mdp
    cd Lambda_$i/EM
    gmx grompp -p $top -f em.mdp -c ../../../08_ion.pdb -o em_$i.tpr -maxwarn 1
    gmx mdrun -deffnm em_$i -v 
    cd $base

    awk '{print $0}' nvt.mdp >> Lambda_$i/NVT/nvt.mdp
    printf "\n" >> Lambda_$i/NVT/nvt.mdp
    printf "init-lambda-state        = $i" >> Lambda_$i/NVT/nvt.mdp
    printf "\n" >> Lambda_$i/NVT/nvt.mdp
    cd Lambda_$i/NVT
    gmx grompp -p $top -f nvt.mdp -c ../../Lambda_$i/EM/em_$i.gro -r ../../Lambda_$i/EM/em_$i.gro -o nvt_$i.tpr -maxwarn 1
    #gmx mdrun -deffnm nvt_$i -v
    cd $base

done
