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
            pmx analyse -f$state frame*/dgdl.xvg --integ_only --quiet
        done
        cd $base/$i/02-PMX/run_$j/
        pmx analyse \
            -iA neA/integA.dat \
            -iB neB/integB.dat \
            -m bar --quiet
    done
done
