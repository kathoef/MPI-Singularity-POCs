
function native_openmpi_setup_env {
 module purge
 module load openmpi/3.1.6
 #MPICC=${MPICC}; MPICXX=${MPICXX}
 export RUNTIME=native_openmpi-3.1.6
 export OSUBENCH_DIR=osu-5.7.1_${RUNTIME}
 export SINGULARITY_CMD=
 export MPIAPI=pmi2
}

function native_intelmpi_setup_env {
 module purge
 module load intelmpi/20.0.4
 #MPICC=${MPICC}; MPICXX=${MPICXX}
 export RUNTIME=native_intelmpi-20.0.4
 export OSUBENCH_DIR=osu-5.7.1_${RUNTIME}
 export SINGULARITY_CMD=
 export MPIAPI=pmi2
}

function singularity_openmpi_setup_env {
 module purge
 module load singularity/3.6.4
 export MPICC=/usr/bin/mpicc
 export MPICXX=/usr/bin/mpicxx
 export RUNTIME=singularity_openmpi-4.1.0
 export OSUBENCH_DIR=osu-5.7.1_${RUNTIME}
 export SINGULARITY_CMD="singularity run ubuntu2104_openmpi.sif"
 export MPIAPI=pmi2
}

function singularity_mpich_setup_env {
 module purge
 module load singularity/3.6.4
 export MPICC=/usr/bin/mpicc
 export MPICXX=/usr/bin/mpicxx
 export RUNTIME=singularity_mpich-3.4.1
 export OSUBENCH_DIR=osu-5.7.1_${RUNTIME}
 export SINGULARITY_CMD="singularity run ubuntu2104_mpich.sif"
 export MPIAPI=pmi2
}

function write_meta_info {
 touch ${LOGPATH}.meta
 echo "timestamp; ${TIMESTAMP}" >> ${LOGPATH}.meta
 echo "osu_exe; ${OSUEXE}" >> ${LOGPATH}.meta
 echo "ntasks; ${SLURM_NTASKS}" >> ${LOGPATH}.meta
 echo "nodes; ${SLURM_JOB_NUM_NODES}" >> ${LOGPATH}.meta
 echo "tasks-per-node; ${SLURM_TASKS_PER_NODE}" >> ${LOGPATH}.meta
 echo "constraint; ${EXP_CONSTRAINT}" >> ${LOGPATH}.meta
 echo "nodelist; ${SLURM_JOB_NODELIST}" >> ${LOGPATH}.meta
 echo "slurm_log; slurm-${SLURM_JOB_ID}.out" >> ${LOGPATH}.meta
 echo "runtime; ${RUNTIME}" >> ${LOGPATH}.meta
 echo "mpi_api; ${MPIAPI}" >> ${LOGPATH}.meta
}

function run_osu_experiment {
 TIMESTAMP=$(date -Is)
 LOGPATH=${EXP_DIR}/${TIMESTAMP}_$(uuidgen)
 CMD="${SINGULARITY_CMD} ./${OSUBENCH_DIR}/${OSUEXE}"
 write_meta_info; srun --mpi=${MPIAPI} bash -c "$CMD" > ${LOGPATH}.log
}

