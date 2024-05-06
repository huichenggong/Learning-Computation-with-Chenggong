#!/bin/bash

cd ../../
base=$PWD

partition=("p32" "p16" "p16" "p16")

# ASP GLU CYM HSD HSE LSN 

for res in ASP GLU CYM HSD HSE LSN 
do
    cd $base
    for i in $(ls -d $res-???)
    do
        cd $base/$i/02-PMX
        for j in 5
        do
            for state in A  B
            do
                cd $base/$i/02-PMX/run_$j/ne$state
                pwd
                cp $base/tmp/02-PMX/run_X/ne$state/md.mdp ./
                
                if [[ $(hostname) == "moa" || $(hostname) == "moa1" || $(hostname) == "moa2" ]]; then
                    cp $base/tmp/02-PMX/run_X/neA/job_pool_slurm.sh ./
                    sed -i "s/JOB_NAME/$i-$j-$state-PMX/g" job_pool_slurm.sh
                    pindex=$(($RANDOM % ${#partition[@]}))
                    part_i=${partition[$pindex]}
                    sed -i "s/PINDEX/$part_i/g"  job_pool_slurm.sh
                    sbatch job_pool_slurm.sh # for slurm (moa)
                elif [[ $(hostname) == "owl" || $(hostname) == "owl1" || $(hostname) == "owl2" ]]; then
                    cp $base/tmp/02-PMX/run_X/neA/jobscript_tmp.sh ./
                    cp $base/tmp/02-PMX/run_X/neA/submit.sh ./
                    ./submit.sh              # for pbs   (owl)
                fi
            
            done
        done
    done
done
