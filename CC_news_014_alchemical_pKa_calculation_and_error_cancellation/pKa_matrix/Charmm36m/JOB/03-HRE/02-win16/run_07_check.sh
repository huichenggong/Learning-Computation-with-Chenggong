#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    cd $base/$i/
    echo "# $i"
    for rep in 1 2 3 4 5
    do
        cd $base/$i/03-HRE/run_$rep/02-win16/
        for win in {0..15}
        do
            if [ ! -f Lambda_$win/md.xvg ] || [ $(tail -n 1 Lambda_$win/md.xvg | awk '{print $1}') != 3750.0000 ]; then
                pwd
                echo "Missing or incomplete file: Lambda_$win/md.xvg $(tail -n 1 Lambda_$win/md.xvg | awk '{print $1}')"
                # cp $base/tmp/03-HRE/run_X/02-win16/jobscript.MD_tmp.sh ./ # please prepare your own jobscript based on your cluster
                # sed -i "s/JOB_NAME/$i-$rep/g" jobscript.MD_tmp.sh
                # sbatch jobscript.MD_tmp.sh
                break
            fi
        done
    done
done
