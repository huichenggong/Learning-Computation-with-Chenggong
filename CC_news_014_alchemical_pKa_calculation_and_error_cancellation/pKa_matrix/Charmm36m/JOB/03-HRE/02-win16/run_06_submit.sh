#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    cd $base/$i/03-HRE
    pwd
    for rep in 1 2 3 
    do
        cd $base/$i/03-HRE/run_$rep/02-win16/
        cp $base/tmp/03-HRE/run_X/02-win16/jobscript.MD_tmp.sh ./
        sed -i "s/JOB_NAME/$i-$rep/g" jobscript.MD_tmp.sh
        sbatch jobscript.MD_tmp.sh
    done
done
