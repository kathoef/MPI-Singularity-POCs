#!/bin/bash

cd "$EXPDIR"/build
"$MITGCM"/tools/genmake2 -rootdir "$MITGCM" -mods ../code -mpi -optfile "$MITGCM"/tools/build_options/linux_amd64_gfortran
make depend
make

