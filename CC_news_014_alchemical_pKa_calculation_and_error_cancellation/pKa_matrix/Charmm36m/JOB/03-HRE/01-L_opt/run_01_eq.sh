#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    mkdir -p $base/$i/03-HRE
    cd $base/$i/03-HRE
    pwd
    cp $base/tmp/03-HRE/run_X/ ./run_1 -r
    
    cd $base/$i/03-HRE/run_1/01-L_opt/0/
    sed -i "s/JOBNAME/$i-0/g" jobscript.64win.sh
    sbatch jobscript.64win.sh
    cd $base/$i/03-HRE/run_1/01-L_opt/1/
    sed -i "s/JOBNAME/$i-1/g" jobscript.64win.sh
    sbatch jobscript.64win.sh
    
done
