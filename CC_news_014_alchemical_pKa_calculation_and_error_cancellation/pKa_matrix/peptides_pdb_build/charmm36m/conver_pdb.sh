#!/bin/bash

export GMXLIB="$HOME/Downloads/pmx/src/pmx/data/mutff/"

# check if charmm36-jul202X.ff exists
if [ ! -d $GMXLIB/charmm36m-mut.ff ]; then
    echo "charmm36m-mut.ff does not exist"
    echo "Please download pmx from github"
    echo " and set the GMXLIB pointing to the pmx/src/pmx/data/mutff/ directory in the script."
    echo "This script will exit from here."
    exit 1
fi

# residues which has the same name in AMBER and Charmm
for res in ASP ASH GLU GLH CYS CYM HID HIE HIP LYN LYS
do
    cp ../amber14sb/$res.pdb ./$res-in.pdb
    # sed remove the line with "N   NHE"
    sed -i '/N   NHE/d' $res-in.pdb
    sed -i '/HN1 NHE/d' $res-in.pdb
    sed -i '/HN2 NHE/d' $res-in.pdb
done

# residues which has different name in AMBER and Charmm
mv ASH-in.pdb ASPP-in.pdb
sed -i 's/ASH /ASPP/g' ASPP-in.pdb
mv GLH-in.pdb GLUP-in.pdb
sed -i 's/GLH /GLUP/g' GLUP-in.pdb
mv HID-in.pdb HSD-in.pdb
sed -i 's/HID/HSD/g' HSD-in.pdb
mv HIE-in.pdb HSE-in.pdb
sed -i 's/HIE/HSE/g' HSE-in.pdb
mv HIP-in.pdb HSP-in.pdb
sed -i 's/HIP/HSP/g' HSP-in.pdb
mv LYN-in.pdb LSN-in.pdb
sed -i 's/LYN/LSN/g' LSN-in.pdb

for res in ASP GLU CYS CYM LYS ASPP GLUP HSD HSE HSP LSN
do
    # those terminus indexes only work for charmm36m-mut, we select None for ACE and CT2 for NH2
    echo -e "3\n2" | gmx pdb2gmx -f $res-in.pdb  -o $res.pdb -ignh -ter -ff charmm36m-mut -water tip3p
    # echo -e "8\n2" | gmx pdb2gmx -f $res-in.pdb  -o $res.pdb -ignh -ter -ff charmm36-jul2022 -water tip3p
    # echo -e "6\n3" | gmx pdb2gmx -f $res-in.pdb  -o $res.pdb -ignh -ter -ff charmm36-jul2021 -water tip3p
done


rm topol.top
rm \#*
rm *-in.pdb
rm *.itp
