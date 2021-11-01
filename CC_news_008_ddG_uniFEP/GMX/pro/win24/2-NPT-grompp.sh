#!/bin/bash
base=$PWD
top=../../../topol.top
for i in {0..24};
do
    awk '{print $0}' npt_10.mdp >> Lambda_$i/NPT/npt_10.mdp
    printf "\n" >> Lambda_$i/NPT/npt_10.mdp
    printf "init-lambda-state        = $i" >> Lambda_$i/NPT/npt_10.mdp
    printf "\n" >> Lambda_$i/NPT/npt_10.mdp
    cd Lambda_$i/NPT
    gmx grompp -p $top \
        -f npt_10.mdp \
        -c ../../Lambda_$i/NVT/nvt_$i.gro \
        -r ../../Lambda_$i/NVT/nvt_$i.gro \
        -t ../../Lambda_$i/NVT/nvt_$i.cpt \
        -o npt_$i.tpr -maxwarn 1
    #break
    g_submit -s npt_$i.tpr -deffnm npt_$i -nomail -days 0.1
    cd $base

done
