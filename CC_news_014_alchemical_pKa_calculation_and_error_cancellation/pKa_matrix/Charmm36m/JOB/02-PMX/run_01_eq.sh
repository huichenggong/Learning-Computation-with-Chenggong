#!/bin/bash

cd ../../
base=$PWD

for i in $(ls -d ???-???); do
    mkdir -p $base/$i/02-PMX
    for j in 1 2 3 # we run 3 replicas
    do
        cd $base/$i/02-PMX
        cp ../../tmp/02-PMX/run_X/ ./run_$j -r
        cd $base/$i/02-PMX/run_$j/eqA
        gmx grompp -f md.mdp -c ../../../01-pre-eq/Lambda_0/npt.gro -t ../../../01-pre-eq/Lambda_0/npt.cpt -r ../../../01-pre-eq/Lambda_0/npt.gro -p ../../../topol.top -o md > grompp_md.log 2>&1 &
        cd $base/$i/02-PMX/run_$j/eqB
        gmx grompp -f md.mdp -c ../../../01-pre-eq/Lambda_1/npt.gro -t ../../../01-pre-eq/Lambda_1/npt.cpt -r ../../../01-pre-eq/Lambda_1/npt.gro -p ../../../topol.top -o md > grompp_md.log 2>&1 &
        wait
        # cd $base/$i/02-PMX/run_$j/eqA
        # gmx mdrun -s md.tpr -deffnm md
        # cd $base/$i/02-PMX/run_$j/eqB
        # gmx mdrun -s md.tpr -deffnm md
        cd $base/$i/02-PMX/run_$j
        g_submit -s md.tpr -multidir eqA/ eqB/ -deffnm md -nslots 4,8 -days 0.5 -nomail -N $i-$j # please prepare your own jobscript here
    done
done
