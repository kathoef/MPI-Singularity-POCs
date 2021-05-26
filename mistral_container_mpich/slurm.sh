#!/bin/bash
#SBATCH --job-name=mpich
#SBATCH --nodes=3
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=compute

# Modules

module purge
module load singularity/3.6.1-gcc-9.1.0
module list

srun --mpi=list

# Compile

rm -f mpitest_exe
singularity exec ../mpich1604.sif mpicc -o mpitest_exe ../mpitest.c

# Execute

CMD='hostname; singularity exec ../mpich1604.sif ./mpitest_exe'

srun --mpi=none --ntasks=3 bash -c "$CMD"
srun --mpi=pmi2 --ntasks=3 bash -c "$CMD"

