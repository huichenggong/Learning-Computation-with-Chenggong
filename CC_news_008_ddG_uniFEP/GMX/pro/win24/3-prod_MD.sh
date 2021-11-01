#!/bin/bash
base=$PWD
top=../../../topol.top
for i in {0..24};
do
    awk '{print $0}' md.mdp >> Lambda_$i/MD/md.mdp
    printf "\n" >> Lambda_$i/MD/npt_10.mdp
    printf "init-lambda-state        = $i" >> Lambda_$i/MD/md.mdp
    printf "\n" >> Lambda_$i/MD/npt_10.mdp
    cd Lambda_$i/MD
    gmx grompp -p $top \
        -f md.mdp \
        -c ../../Lambda_$i/NPT/npt_$i.gro \
        -t ../../Lambda_$i/NPT/npt_$i.cpt \
        -o md_$i.tpr \
        -maxwarn 1
    g_submit -s md_$i.tpr -deffnm md_$i -nomail -days 0.3
    cd $base

done
