echo "distSS1" | gmx distance -s ../../data/md.tpr \
    -f ../../data/fix_atom_c_40ps.xtc \
    -n ../../data/index_CYS159-CYS284_PRO155-GLY280.ndx \
    -oall Cys159-284-CA.xvg
