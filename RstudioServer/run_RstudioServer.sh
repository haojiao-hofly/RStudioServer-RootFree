#!/bin/bash

PORT=8787
WORKDIR=$(dirname "$0")
USER=$(whoami)
PASSWORD=$(cat ${WORKDIR}/password)

# path
SOFT_DIR=/path/to/project  #full path
CONTAINER="${SOFT_DIR}/rstudio_latest.sif" 
MICROMAMBA=/path/to/micromamba  #full path
MICROMAMBA_ENV=/path/to/micromamba_env #full path
CONDA_R_PREFIX=$MICROMAMBA_ENV/envs/$1

export PATH=$PATH:/usr/local/bin # singularity bin path

chmod +x ${SOFT_DIR}/*.sh
WORKDIR=$WORKDIR \
USER=$USER \
PASSWORD=$PASSWORD \
CONDA_R_PREFIX=$CONDA_R_PREFIX \
MICROMAMBA_ENV=$MICROMAMBA_ENV \
MICROMAMBA=$MICROMAMBA \
CONTAINER=$CONTAINER \
PORT=$PORT \
sh ${SOFT_DIR}/run_singularity.sh  
