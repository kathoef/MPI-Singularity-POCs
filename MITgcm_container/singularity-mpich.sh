#!/bin/bash
#SBATCH --nodes=2
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --partition=cluster

export MITGCM=$HOME/github/MPI-Singularity-PoC/MITgcm_container/MITgcm

# Setup

export EXPDIR=$PWD/test1

cp -r $MITGCM/verification/exp2 $EXPDIR
cp $EXPDIR/code/SIZE.h_mpi $EXPDIR/code/SIZE.h

# Compile

module load singularity/3.6.4

export CONTAINER=$HOME/github/MPI-Singularity-PoC/MITgcm_container/mpich2104.sif
export MPI_HOME=/usr/bin
export MPI_INC_DIR=/usr/include/x86_64-linux-gnu/mpich

# dirty Singularity container compatibility fix...
cp $MITGCM/tools/genmake2 $MITGCM/tools/genmake2_orig
sed -i '1864s/check_fortran_compiler/echo Skipping check_fortran_compiler.../' $MITGCM/tools/genmake2
singularity run $CONTAINER bash compile.sh > compile.log 2>&1
cp $MITGCM/tools/genmake2_orig $MITGCM/tools/genmake2

# Prepare

bash prepare.sh

# Execute

module list
cd $EXPDIR/run
srun --mpi=pmi2 --ntasks=2 bash -c "hostname; singularity exec $CONTAINER ./mitgcmuv"

jobinfo

