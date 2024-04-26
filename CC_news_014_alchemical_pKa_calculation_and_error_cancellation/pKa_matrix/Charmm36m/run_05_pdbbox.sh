#!/bin/bash

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
            cp $b1-$a1.pdb $b1-$a1-tmp.pdb
            cp $a2-$b2.pdb $a2-$b2-tmp.pdb
            # sed remove line with "ENDMDL"
            sed -i '/ENDMDL/d' $b1-$a1-tmp.pdb
            echo "TER" >> $b1-$a1-tmp.pdb
            sed -i '/ENDMDL/d' $a2-$b2-tmp.pdb
            echo "TER" >> $a2-$b2-tmp.pdb
            gmx editconf -f $a2-$b2-tmp.pdb -o $a2-$b2-tmp-trans2.pdb -translate 0 0 -5 -rotate 0 0 90
            # sed replace "A   " with "B   "
            sed -i "s/A   /B   /g" $a2-$b2-tmp-trans2.pdb
            cat $a2-$b2-tmp-trans2.pdb >> $b1-$a1-tmp.pdb
            gmx editconf -f $b1-$a1-tmp.pdb -o box.pdb -bt triclinic -box 5.1 5.1 10.2 -c 
            rm $b1-$a1-tmp.pdb $a2-$b2-tmp.pdb $a2-$b2-tmp-trans2.pdb
            gmx solvate -cp box.pdb  -cs spc216 -p topol.top  -o box_solv.pdb -maxsol 8062


        fi
        
    done
    # break
done