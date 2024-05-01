#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    cd $base/$i/03-HRE
    mkdir run_2 run_3 -p
    for rep in 1 2 3 
    do
        cd $base/$i/03-HRE/run_$rep
        cp $base/tmp/03-HRE/run_X/02-win16/ ./ -r
    done
done
