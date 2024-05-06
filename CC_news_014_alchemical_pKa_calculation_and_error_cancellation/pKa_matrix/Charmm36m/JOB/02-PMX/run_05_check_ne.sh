#!/bin/bash

cd ../../
base=$PWD

for i in $(ls -d ???-???); do
    cd $base/$i/
    echo "# $i"
    for j in 1 2 3 4 5
    do
        for state in A  B
        do
            cd $base/$i/02-PMX/run_$j/ne$state
            # remove unfinished.dat if exists
            if [ -f unfinished.dat ]; then
                rm unfinished.dat
            fi
            # print all folders which does not contain the file "dgdl.xvg", or the first word of the last line of "dgdl.xvg" is not 80.0000
            for k in {1..100}; do
                if [ ! -f frame$k/dgdl.xvg ] || [ $(tail -n 1 frame$k/dgdl.xvg | awk '{print $1}') != 50.0000 ]; then
                    echo frame$k >> unfinished.dat
                fi
            done
            if [ -f unfinished.dat ]; then
                echo "cd $PWD"
                echo "# $(cat -n unfinished.dat | tail -n 1)"
                cp $base/tmp/02-PMX/run_X/neA/jobscript_add.sh ./
                # replace keywork "JOBNAME"
                sed -i "s/JOBNAME/$i-$j-ne$state-PMX/g" jobscript_add.sh
                # job_hour should be int(line_number/10)+1
                job_hour=$(cat unfinished.dat | wc -l | awk '{print int($1/8)+1}')
                sed -i "s/JOBHOUR/$job_hour/g" jobscript_add.sh
            fi
        done
    done
done
