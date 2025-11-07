#!/bin/bash

script_dir=$(dirname "$0")

PORT=${PORT:-10086}
if [[ -f "$WORKDIR/password" ]]; then
    # 如果文件存在，将文件内容赋值给 PASSWORD
    PASSWORD=$(cat "$WORKDIR/password")
fi
if [[ -z "$PASSWORD" ]]; then
    # 如果 PASSWORD 为空，赋值为 notsafe
    PASSWORD="J%tt5gr4U@Grt8WeH2#6Kw4"
fi
RSTUDIO_TMP=$WORKDIR/tmp/
mkdir -p $RSTUDIO_TMP/{run,var-lib-rstudio-server,local-share-rstudio}

R_BIN=${CONDA_R_PREFIX}/bin/R
PY_BIN=${CONDA_R_PREFIX}/bin/python

if [ ! -f $CONTAINER ]; then
	singularity build --fakeroot $CONTAINER Singularity
fi

if [ -z "${CONDA_R_PREFIX}" ]; then
  echo "Activate a conda env or specify \${CONDA_R_PREFIX}"
  exit 1
fi

echo "Starting rstudio service on port $PORT ..."
singularity run \
	--bind $RSTUDIO_TMP/run:/run \
	--bind $RSTUDIO_TMP/var-lib-rstudio-server:/var/lib/rstudio-server \
	--bind /sys/fs/cgroup/:/sys/fs/cgroup/:ro \
	`# --bind /import/path:/import/path ` \
	--bind $MICROMAMBA:/usr/bin/micromamba \
	--bind $RSTUDIO_TMP/database.conf:/etc/rstudio/database.conf \
	--bind $RSTUDIO_TMP/rsession.conf:/etc/rstudio/rsession.conf \
	--bind $RSTUDIO_TMP/logging.conf:/etc/rstudio/logging.conf \
	--bind $RSTUDIO_TMP/local-share-rstudio:/home/rstudio/.local/share/rstudio \
	--bind ${CONDA_R_PREFIX}:${CONDA_R_PREFIX} \
	--bind ${script_dir}/conda.sh:/opt/conda/etc/profile.d/conda.sh \
	--bind /usr/share/fonts/:/usr/share/fonts/ \
	--env CONDA_R_PREFIX=${CONDA_R_PREFIX} \
	--env RSTUDIO_WHICH_R=$R_BIN \
	--env RETICULATE_PYTHON=$PY_BIN \
	--env PASSWORD=$PASSWORD \
	--env PORT=$PORT \
	--env USER=$USER \
	--env MICROMAMBA_ENV=$MICROMAMBA_ENV \
	$CONTAINER \
	${script_dir}/init.sh

