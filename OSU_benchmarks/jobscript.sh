#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=cluster

source experiments.sh

function run_experiments {

 N=10

 OSUEXE=mpi/startup/osu_init
 for n in $(seq 1 $N); do run_osu_experiment; done

 OSUEXE=mpi/collective/osu_allgather
 for n in $(seq 1 $N); do run_osu_experiment; done

}

native_openmpi_setup_env
run_experiments

native_intelmpi_setup_env
run_experiments

singularity_mpich_setup_env
run_experiments

