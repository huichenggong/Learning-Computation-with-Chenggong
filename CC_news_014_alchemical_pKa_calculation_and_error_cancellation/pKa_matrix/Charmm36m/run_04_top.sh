#!/bin/bash

# This script will assemble the itp files to generate the topol.top file.

declare -A pairs_array  # Declare associative array
index=0  # Initialize index

# Read the file line by line
while IFS=' ' read -r acid base; do
    # Store the pair in the associative array with the index as key
    pairs_array[$index]="$acid $base"
    ((index++))  # Increment index
done < "pair.dat"

export GMXLIB=/home/chui/Downloads/pmx/src/pmx/data/mutff

# To access and print the elements, iterate over the array
base=$PWD
for i in "${!pairs_array[@]}"; do
    for j in "${!pairs_array[@]}"; do
        cd $base
        read b1 a1 <<< "${pairs_array[$i]}"
        read b2 a2 <<< "${pairs_array[$j]}"
        if [ $b1 != $b2 ]; then
            cd $b1-$b2
            pwd
            cp ../tmp/topol_tmp.top ./topol.top
            # sed replace PROTEIN_A
            sed -i "s/PROTEIN_A/$b1-$a1-withB-mass/g" topol.top
            sed -i "s/PROTEIN_B/$a2-$b2-withB-mass/g" topol.top

        fi
        
    done
    # break
done
