#!/bin/bash

# This script will prepare all the possible titration-mutations pairs using pmx.
# There will be 2 residues in one folder, in such format: 
#    res1_deprotonated-res1_protonated
#    res2_protonated-res2_deprotonated

rm ???-??? -r

declare -A pairs_array  # Declare associative array
index=0  # Initialize index

# Read the file line by line
while IFS=' ' read -r acid base; do
    # Store the pair in the associative array with the index as key
    pairs_array[$index]="$acid $base"
    ((index++))  # Increment index
done < "pair.dat"

export GMXLIB=/home/chui/Downloads/pmx/src/pmx/data/mutff
# check if charmm36-jul202X.ff exists
if [ ! -d $GMXLIB/charmm36m-mut.ff ]; then
    echo "charmm36m-mut.ff does not exist"
    echo "Please download pmx from github"
    echo " and set the GMXLIB pointing to the pmx/src/pmx/data/mutff/ directory in the script."
    echo "This script will exit from here."
    exit 1
fi


# To access and print the elements, iterate over the array
base=$PWD
for i in "${!pairs_array[@]}"; do
    for j in "${!pairs_array[@]}"; do
        cd $base
        read b1 a1 <<< "${pairs_array[$i]}"
        read b2 a2 <<< "${pairs_array[$j]}"
        if [ $b1 != $b2 ]; then
            echo "$b1 $b2"
            mkdir $b1-$b2
            cp ../peptides_pdb_build/charmm36m/$b1.pdb $b1-$b2/
            cp ../peptides_pdb_build/charmm36m/$a2.pdb $b1-$b2/
            cd $b1-$b2
            echo -e "6\n3\n$a1\nn" | pmx mutate -f $b1.pdb -o $b1-$a1.pdb > $b1-$a1.log
            echo -e "6\n3\n$b2\nn" | pmx mutate -f $a2.pdb -o $a2-$b2.pdb > $a2-$b2.log
        fi
    done
done
