#!/bin/bash

# This scirpt will use pmx to generate the state B in the itp file.
# 1 atom center of mass restrain will also be added.

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
            echo 6 | pmx gentop -p $b1-$a1.itp -o $b1-$a1-withB.itp  # pmx will remove moleculetype section
            echo 6 | pmx gentop -p $a2-$b2.itp -o $a2-$b2-withB.itp
            # sed replace Protein_chain_A with Protein_chain_B
            sed -i "s/Protein_chain_A/Protein_chain_B/g" $a2-$b2-withB.itp
            cat ../tmp/res_CA.itp >> $b1-$a1-withB.itp
            cat ../tmp/res_CA.itp >> $a2-$b2-withB.itp
        fi
        
    done
    # break
done