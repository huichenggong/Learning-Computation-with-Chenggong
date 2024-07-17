#!/bin/bash

# copy paste the charmm36m-mut.ff directory from pmx so that we no longer need to set GMXLIB.

export GMXLIB=/home/chui/Downloads/pmx/src/pmx/data/mutff
# check if charmm36-jul202X.ff exists
if [ ! -d $GMXLIB/charmm36m-mut.ff ]; then
    echo "charmm36m-mut.ff does not exist"
    echo "Please download pmx from github"
    echo " and set the GMXLIB pointing to the pmx/src/pmx/data/mutff/ directory in the script."
    echo "This script will exit from here."
    exit 1
fi

cp $GMXLIB/charmm36m-mut.ff/ ./ -r
base=$PWD
for i in $(ls -d ???-???)
do
    cd $base/$i
    ln -s ../charmm36m-mut.ff
done
