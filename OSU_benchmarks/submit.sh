#!/bin/bash

source experiments.sh

# Compile

native_openmpi_setup_env
./compile.sh

native_intelmpi_setup_env
./compile.sh

#singularity_openmpi_setup_env
#${SINGULARITY_CMD} ./compile.sh

singularity_mpich_setup_env
${SINGULARITY_CMD} ./compile.sh

module purge

# Submit

export EXP_DIR=nesh_logs
export EXP_CONSTRAINT=cascade,mem192
mkdir -p ${EXP_DIR}

NTASKS=8

for NODES in 8 4 2 1; do

sbatch --ntasks=${NTASKS} --nodes=${NODES} --tasks-per-node=$[$NTASKS/$NODES] \
--constraint=${EXP_CONSTRAINT} --output=${EXP_DIR}/slurm-%j.out jobscript.sh

done

