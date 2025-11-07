#!/bin/bash

eval "$(micromamba shell hook --shell bash )"

micromamba activate $CONDA_R_PREFIX && \
rserver \
  --www-address=0.0.0.0 \
  --www-port=$PORT \
  --rsession-which-r=$RSTUDIO_WHICH_R \
  --rsession-ld-library-path=$CONDA_R_PREFIX/lib \
  `# optional: old behaviour of R sessions` \
  --auth-timeout-minutes=0 --auth-stay-signed-in-days=30  \
  `# activate password authentication` \
  --auth-none=0  --auth-pam-helper-path=pam-helper \
  --server-user $USER

