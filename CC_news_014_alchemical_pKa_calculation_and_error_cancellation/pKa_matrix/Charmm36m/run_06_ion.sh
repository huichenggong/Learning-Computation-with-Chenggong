#!/bin/bash

# This script will add NaCL to 150 mmol and neutralize the system. topol.top will be modified.

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
            gmx grompp -f ../MDP/genion.mdp  -c box_solv.pdb  -p topol.top  -o box_solv -maxwarn 1
            echo "SOL" | gmx genion -s box_solv.tpr -p topol.top -neutral -conc 0.15 -o ions.pdb

            # sed -i "s/NA   NA/SOD SOD/g" ions.pdb
            # sed -i "s/CL   CL/CLA CLA/g" ions.pdb
            # sed -i "s/NA/SOD/g" topol.top
            # sed -i "s/CL/CLA/g" topol.top


        fi
        
    done
    # break
done