# MPI-Singularity-PoC

Testing the portability (and performance!) of containerized MPI simulation codes across HPC systems.
Currently, the following topics are covered,

* container image and code portability across HPC systems: [hello_across_machines](./hello_across_machines)
* containerized MITgcm test simulation: [MITgcm_container](./MITgcm_container)
* native vs. containerized MPI performance benchmarks: [OSU_benchmarks](./OSU_benchmarks) (WIP!)

## References

* https://slurm.schedmd.com/mpi_guide.html
* https://sylabs.io/guides/3.7/user-guide/mpi.html
* https://sarus.readthedocs.io/en/stable/cookbook/osu_mb/osu_mb.html
* https://sarus.readthedocs.io/en/stable/user/abi_compatibility.html
* https://sarus.readthedocs.io/en/stable/user/user_guide.html#running-mpi-applications-without-the-native-mpi-hook
