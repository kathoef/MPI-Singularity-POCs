#!/bin/bash
#SBATCH --job-name=mpi
#SBATCH --nodes=3
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=cluster

# bash mpitest.sh > mpitest.log 2>&1

# Modules

module purge
module load intelmpi/20.0.4
#module load intelmpi/19.0.4
#module load openmpi-intel19/3.1.6
#module load openmpi-intel20/3.1.6
#module load openmpi/3.1.6
module list

# Compile

rm -f mpitest_exe
mpicc -o mpitest_exe ../mpitest.c

# Execute

mpirun -np 3 ./mpitest_exe

