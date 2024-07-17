#!/bin/bash

# This script will modify the termini and call pdb2gmx to generate the itp files.

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
            # sed remove "HT1 ALA"
            cp $b1-$a1.pdb $b1-$a1-in.pdb
            cp $a2-$b2.pdb $a2-$b2-in.pdb
            sed -i '/NT  ALA/d' $b1-$a1-in.pdb
            sed -i '/HT1 ALA/d' $b1-$a1-in.pdb
            sed -i '/HT2 ALA/d' $b1-$a1-in.pdb
            echo -e "3\n2" | gmx pdb2gmx -f $b1-$a1-in.pdb -o $b1-$a1.gro \
            -ff charmm36m-mut -water tip3p -ter
            # sed remove everthing after "Include water topology"
            sed -i '/Include water topology/,$d' topol.top
            mv topol.top $b1-$a1.itp
            mv posre.itp $b1-$a1-posre-heavy.itp
            sed -i "s/posre\.itp/$b1-$a1-posre-heavy\.itp/g" $b1-$a1.itp


            sed -i '/NT  ALA/d' $a2-$b2-in.pdb
            sed -i '/HT1 ALA/d' $a2-$b2-in.pdb
            sed -i '/HT2 ALA/d' $a2-$b2-in.pdb
            echo -e "3\n2" | gmx pdb2gmx -f $a2-$b2-in.pdb -o $a2-$b2.gro \
            -ff charmm36m-mut -water tip3p -ter
            # sed remove everthing after "Include water topology"
            sed -i '/Include water topology/,$d' topol.top
            mv topol.top $a2-$b2.itp
            mv posre.itp $a2-$b2-posre-heavy.itp
            sed -i "s/posre\.itp/$a2-$b2-posre-heavy\.itp/g" $a2-$b2.itp
            # break
        fi
        
    done
    # break
done