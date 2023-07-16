#!/usr/bin/env python3
import mdtraj as md
import time
import numpy as np
import pandas as pd

dist_list = []
xtc = '../../data/fix_atom_c_40ps.xtc'
pdb = '../../data/npt.pdb'
for traj in md.iterload(xtc, top=pdb, chunk=100):
    at1 = traj.topology.select('resSeq 159 and resname CYS and name CA')
    at2 = traj.topology.select('resSeq 284 and resname CYS and name CA')
    at3 = traj.topology.select('resSeq 155 and resname PRO and name CA')
    at4 = traj.topology.select('resSeq 280 and resname GLY and name CA')
    atom_pairs = [[at1[0],at2[1]],
                  [at1[1],at2[0]],
                  [at3[0],at4[1]],
                  [at3[1],at4[0]],
                  ]

    distances = md.compute_distances(traj, atom_pairs)
    dist_list.append(distances)
distances = np.concatenate(dist_list)
df = pd.DataFrame({'CYS159-CYS284_A': distances[:,0],
                   'CYS159-CYS284_B': distances[:,1],
                   'PRO155-GLY280_A': distances[:,2],
                   'PRO155-GLY280_B': distances[:,3],})
df.to_csv('distances.csv', index=False)
