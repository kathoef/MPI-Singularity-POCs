# MPI-Singularity-PoC

Testing the portability (and performance!) of containerized MPI simulation codes across HPC systems.
Currently covers,

* container image and code portability across HPC systems: [hello_across_machines](./hello_across_machines)
* containerized MITgcm test simulation: [MITgcm_container](./MITgcm_container)
* native vs. containerized MPI performance benchmarks: [OSU_benchmarks](./OSU_benchmarks) (WIP!)

## References

* https://slurm.schedmd.com/mpi_guide.html
* https://sylabs.io/guides/3.7/user-guide/mpi.html
