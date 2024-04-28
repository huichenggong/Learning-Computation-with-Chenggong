#!/bin/bash

cd ../../
base=$PWD

for i in $(ls -d ???-???); do
    for j in 1 2 3 # we run 3 replicas
    do
        for state in A B
        do
            cd $base/$i/02-PMX/run_$j/eq$state
            # there should be a md.gro file and the first word of the line of file md.xvg should be "20000.0000"
            if [ -f md.gro ] && [ $(tail -n 1 md.xvg | awk '{print $1}') == "20000.0000" ]; then
                : # pass
            else
                pwd
                echo "Pls check md.gro or md.xvg"
            fi
        done
    done
done
