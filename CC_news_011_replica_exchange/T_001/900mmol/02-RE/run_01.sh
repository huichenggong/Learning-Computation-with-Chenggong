rep=(  "0"      "1"      "2"      "3"      "4"      "5"     )
tem=(  "310.00" "312.43" "314.88" "317.34" "319.82" "322.31")

for i in "${!rep[@]}"
do
  echo $i ${tem[$i]}
  mkdir rep_$i 
  cd rep_$i 
  cp ../nvt-eq.mdp ./
  echo "ref-t = " ${tem[$i]} >> nvt-eq.mdp
  gmx grompp -f nvt-eq.mdp -c ../../01-eq/npt.gro -r ../../01-eq/npt.gro -p ../../topol.top -o nvt
  gmx mdrun -v -deffnm nvt

  cp ../md_0.mdp ./
  echo "ref-t = " ${tem[$i]} >> md_0.mdp
  gmx grompp -f md_0.mdp -c nvt.gro -t nvt.cpt -p ../../topol.top \
  -o md


  cd ../
done
