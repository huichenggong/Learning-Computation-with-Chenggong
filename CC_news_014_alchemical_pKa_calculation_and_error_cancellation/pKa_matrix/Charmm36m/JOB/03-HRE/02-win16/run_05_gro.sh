#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    cd $base/$i/03-HRE
    pwd
    for rep in 4 5 
    do
        cd $base/$i/03-HRE/run_$rep/02-win16/
        cp $base/tmp/03-HRE/run_X/02-win16/MDP/md.mdp ./MDP/
        rm Lambda_* -r
        bash ../../run_1/02-win16/prepare.sh
    done
done
