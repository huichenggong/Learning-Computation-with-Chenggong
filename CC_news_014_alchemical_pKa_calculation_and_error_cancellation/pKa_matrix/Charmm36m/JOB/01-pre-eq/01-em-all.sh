cd ../../
base=$PWD
for i in $(ls -d ???-???)
do
    cd $base/$i
    cp ../tmp/01-pre-eq/ ./ -r
    cd 01-pre-eq/Lambda_0
    gmx grompp -f em.mdp -c ../../ions.pdb -r ../../ions.pdb -p ../../topol.top -o em
    gmx mdrun -deffnm em
    gmx grompp -f em.mdp -c em.gro -r ../../ions.pdb -p ../../topol.top -o npt
    gmx mdrun -deffnm npt
    cd ../../01-pre-eq/Lambda_1
    gmx grompp -f em.mdp -c ../../ions.pdb -r ../../ions.pdb -p ../../topol.top -o em
    gmx mdrun -deffnm em
    gmx grompp -f em.mdp -c em.gro -r ../../ions.pdb -p ../../topol.top -o npt
    gmx mdrun -deffnm npt
done
