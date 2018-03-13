#!/usr/bin/env bash

THIS_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
THIS_NAME=$(basename "${BASH_SOURCE[0]%.*}")
INSTALL_PATH=${THIS_PATH}/${THIS_NAME}

BASE_URL=ftp://ftp.irisa.fr/local/texmex/corpus/
FILENAME=siftsmall.tar.gz

echo "Installing ${THIS_NAME} data ..."

if ! [ -d ${INSTALL_PATH} ]; then
  mkdir -p ${INSTALL_PATH}
  pushd ${THIS_PATH}
  curl -LO --progress-bar ${BASE_URL}/${FILENAME}
  tar xvf ${FILENAME}
  rm ${FILENAME}
  popd
fi
echo "✅ ${INSTALL_PATH}"
