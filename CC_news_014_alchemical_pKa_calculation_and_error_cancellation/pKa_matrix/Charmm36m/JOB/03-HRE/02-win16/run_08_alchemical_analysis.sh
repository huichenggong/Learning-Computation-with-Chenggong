#!/bin/bash

cd ../../../
base=$PWD

for i in $(ls -d ???-???); do
    cd $base/$i/
    echo "# $i"
    for rep in 1 2 3 4 5
    do
        cd $base/$i/03-HRE/run_$rep/02-win16/
        mkdir results
        cd results
        for l in {0..15}
        do
            head -n 31295 ../Lambda_$l/md.xvg >  ./md_$l.xvg
        done
        alchemical_analysis -d ./ -q xvg -p md_ -u kcal > alchemical_analysis.log
        rm *.xvg

    done
done
