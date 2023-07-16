#!/usr/bin/env python3
import MDAnalysis as mda
from MDAnalysis.lib.distances import calc_bonds
import numpy as np
import pandas as pd

xtc = '../../data/fix_atom_c_40ps.xtc'
pdb = '../../data/npt.pdb'
u = mda.Universe(pdb, xtc)
# CYS159-CYS284_PRO155-GLY280
at1 = u.select_atoms('resid 159 and resname CYS and name CA and chainID A')
at2 = u.select_atoms('resid 159 and resname CYS and name CA and chainID B')

at3 = u.select_atoms('resid 284 and resname CYS and name CA and chainID A')
at4 = u.select_atoms('resid 284 and resname CYS and name CA and chainID B')

at5 = u.select_atoms('resid 155 and resname PRO and name CA and chainID A')
at6 = u.select_atoms('resid 155 and resname PRO and name CA and chainID B')

at7 = u.select_atoms('resid 280 and resname GLY and name CA and chainID A')
at8 = u.select_atoms('resid 280 and resname GLY and name CA and chainID B')

dist_list = []
for ts in u.trajectory:
    # Calculate the distance
    dist1 = calc_bonds(at1.positions, at4.positions)
    dist2 = calc_bonds(at2.positions, at3.positions)
    dist3 = calc_bonds(at5.positions, at8.positions)
    dist4 = calc_bonds(at6.positions, at7.positions)
    dist_list.append([dist1[0], dist2[0], dist3[0], dist4[0]])
distances = np.array(dist_list)
df = pd.DataFrame({'CYS159-CYS284_A': distances[:,0],
                   'CYS159-CYS284_B': distances[:,1],
                   'PRO155-GLY280_A': distances[:,2],
                   'PRO155-GLY280_B': distances[:,3],})
df.to_csv('distances.csv', index=False)

