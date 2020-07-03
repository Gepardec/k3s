#!/bin/bash

#######################
# READ ONLY VARIABLES #
#######################

readonly SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly TOPLEVEL_DIR=$( cd ${SCRIPT_DIR}/ > /dev/null && pwd )
ENGINE=${CONTAINER_ENGINE}

main () {

  if [[ "x${ENGINE}" == "x" ]]; then
    ENGINE=docker
  fi

  echo "${ENGINE}"
  echo "${TOPLEVEL_DIR}"


  set -e
  echo """
    ${ENGINE} run --rm -it \
    -v ${TOPLEVEL_DIR}/:/mnt/k3s \
    gepardec/hogarama-bootstrap:1.0.0\
    /mnt/k3s/scripts/setup.sh ${@}
    """
  ${ENGINE} run --rm -it \
    -v ${TOPLEVEL_DIR}/:/mnt/k3s \
    gepardec/hogarama-bootstrap:1.0.0\
    /mnt/k3s/scripts/setup.sh ${@}
  set +e
}

main $@