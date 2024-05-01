#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    for state in 0 1
    do
        cd $base/$i/03-HRE/run_1/01-L_opt/$state
        for win in {0..63}
        do
            # there should be a md.gro file and the first word of the line of file md.xvg should be "finishing time (ps)"
            if [ ! -f "Lambda_$win/md.gro" ] || [ ! -f "Lambda_$win/md.xvg" ] || [ "$(tail -n 1 "Lambda_$win/md.xvg" | awk '{print $1}')" != "100.0000" ]; then
                echo "#" $PWD
                echo "# Pls check Lambda_$win/md.gro or Lambda_$win/md.xvg"
                
                # if not finished, resubmit the job. please take care of the jobscript yourself according to your own cluster(s).
                cp $base/tmp/03-HRE/run_X/01-L_opt/0/jobscript.64win.sh ./
                sed -i "s/JOBNAME/$i-$(basename $PWD)/g" jobscript.64win.sh
                sbatch jobscript.64win.sh
                break
            fi
        done
    done
done
