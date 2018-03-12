#!/usr/bin/env bash

THIS_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
THIS_NAME=$(basename "${BASH_SOURCE[0]%.*}")
INSTALL_PATH=${THIS_PATH}/${THIS_NAME}
mkdir -p ${INSTALL_PATH}

BASE_URL=ftp://ftp.irisa.fr/local/texmex/corpus/
FILENAME=sift.tar.gz

echo "Installing ${THIS_NAME} data ..."

if ! [ -d ${INSTALL_PATH} ]; then
  curl -LO --progress-bar ${BASE_URL}/${FILENAME}
  tar xvf ${FILENAME}
  rm ${FILENAME}
fi
echo "✅ ${INSTALL_PATH}"
