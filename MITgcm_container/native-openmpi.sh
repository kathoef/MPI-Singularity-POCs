#!/bin/bash
#SBATCH --nodes=2
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --partition=cluster

export MITGCM=$HOME/github/MPI-Singularity-PoC/MITgcm_container/MITgcm

# Setup

export EXPDIR=$PWD/test2

cp -r $MITGCM/verification/exp2 $EXPDIR
cp $EXPDIR/code/SIZE.h_mpi $EXPDIR/code/SIZE.h

# Compile

module load openmpi/3.1.6

export MPI_HOME=/gxfs_work1/gxfs_home_interim/sw/spack/spack0.16.0/usr/opt/spack/linux-rhel8-x86_64/gcc-10.2.0/openmpi-3.1.6-vq6nij2zpkbenfwan5ku3wx6v6ekgguv
export MPI_INC_DIR=/gxfs_work1/gxfs_home_interim/sw/spack/spack0.16.0/usr/opt/spack/linux-rhel8-x86_64/gcc-10.2.0/openmpi-3.1.6-vq6nij2zpkbenfwan5ku3wx6v6ekgguv/include

bash compile.sh > compile.log 2>&1

# Prepare

bash prepare.sh

# Execute

module list
cd $EXPDIR/run
mpirun -np 2 bash -c "hostname; ./mitgcmuv"

jobinfo

