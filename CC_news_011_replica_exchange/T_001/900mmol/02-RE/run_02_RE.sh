mpirun -np 6 gmx_mpi mdrun  \
  -multidir rep_0 rep_1  rep_2  rep_3  rep_4  rep_5  \
  -s md.tpr \
  -deffnm md \
  -replex 500 

