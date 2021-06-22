#!/bin/bash

tar zxvf osu-micro-benchmarks-5.7.1.tgz
mv osu-micro-benchmarks-5.7.1 ${OSUBENCH_DIR}
cd ${OSUBENCH_DIR}
./configure CC=${MPICC} CXX=${MPICXX}
make

