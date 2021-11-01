#!/bin/bash



rm -rf Lambda*
rm -rf \#*
base=$PWD
top=../../../topol.top
for i in {0..20};
do

    mkdir  Lambda_$i
    mkdir Lambda_$i/EM
    mkdir Lambda_$i/NPT
    mkdir Lambda_$i/MD
    awk '{print $0}' em.mdp >> Lambda_$i/EM/em.mdp
    printf "\n" >> Lambda_$i/EM/em.mdp
    printf "init-lambda-state        = $i" >> Lambda_$i/EM/em.mdp
    printf "\n" >> Lambda_$i/EM/em.mdp
    cd Lambda_$i/EM
    gmx grompp -p $top -f em.mdp -c ../../../04_ion_added.gro -o em_$i.tpr -maxwarn 1
#break
    gmx mdrun -deffnm em_$i -v 
    cd ../../

#break
    awk '{print $0}' npt_10.mdp >> Lambda_$i/NPT/npt_10.mdp
    printf "\n" >> Lambda_$i/NPT/npt_10.mdp
    printf "init-lambda-state        = $i" >> Lambda_$i/NPT/npt_10.mdp
    printf "\n" >> Lambda_$i/NPT/npt_10.mdp
    cd Lambda_$i/NPT
    gmx grompp -p $top -f npt_10.mdp -c ../../Lambda_$i/EM/em_$i.gro -o npt_$i.tpr -maxwarn 1
    gmx mdrun -deffnm npt_$i -v
    cd ../../
    
    #break
    awk '{print $0}' md.mdp >> Lambda_$i/MD/md.mdp
    printf "\n" >> Lambda_$i/NPT/npt_10.mdp
    printf "init-lambda-state        = $i" >> Lambda_$i/MD/md.mdp
    printf "\n" >> Lambda_$i/NPT/npt_10.mdp
    cd Lambda_$i/MD
    gmx grompp -p $top -f md.mdp -c ../../Lambda_$i/NPT/npt_$i.gro -t ../../Lambda_$i/NPT/npt_$i.cpt -o md_$i.tpr -maxwarn 1
    
    #break
    cd $base
done
