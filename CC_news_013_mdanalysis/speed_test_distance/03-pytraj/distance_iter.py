#!/usr/bin/env python3
import pytraj as pt
import pandas as pd


xtc = '../../data/fix_atom_c_40ps.xtc'
pdb = '../../data/npt.pdb'

traj = pt.iterload(xtc, top=pdb)
distances = pt.distance(traj, ["(@CA)&(:133)  (@CA)&(:519)",  # 159 284 chain A
                               "(@CA)&(:394)  (@CA)&(:258)",  # 159 284 chain B
                               "(@CA)&(:129)  (@CA)&(:515)",  # 155 280 chain A
                               "(@CA)&(:390)  (@CA)&(:254)",  # 155 280 chain B
                              ])

df = pd.DataFrame({'CYS159-CYS284_A': distances[0,:],
                   'CYS159-CYS284_B': distances[1,:],
                   'PRO155-GLY280_A': distances[2,:],
                   'PRO155-GLY280_B': distances[3,:],})
df.to_csv('distances.csv', index=False)