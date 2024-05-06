#!/bin/bash

cd ../../
base=$PWD

for i in $(ls -d ???-???); do
    for j in 1 2 3 4 5 # we run 5 replicas
    do
        for state in A B
        do
            cd $base/$i/02-PMX/run_$j/
            mkdir ne$state -p 
            cd ne$state
            echo "System" | gmx trjconv -s ../eq$state/md.tpr -f ../eq$state/md.trr -sep -b 200 -dt 200 -o frame_.gro
            for k in $( seq 0 99 ) # put frame_0~9.gro into folder frame1~10
            do 
                n=$((k+1))
                mkdir frame$n
                mv frame_$k.gro frame$n/frame.gro
            done
            
        done
    done
done
