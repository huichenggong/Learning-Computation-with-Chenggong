#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    cd $base/$i/03-HRE
    for rep in 4 5  
    do
        mkdir -p $base/$i/03-HRE/run_$rep
        cd $base/$i/03-HRE/run_$rep
        cp $base/tmp/03-HRE/run_X/02-win16/ ./ -r
    done
done
