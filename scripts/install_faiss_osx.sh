#!/bin/bash


if [ ! -f /usr/local/opt/llvm/bin/clang ]; then
  echo "Warning: /usr/local/opt/llvm/bin/clang was not found. See the README.md for more info."
fi

mkdir build
pushd build > /dev/null
rm -rf faiss
git clone https://github.com/facebookresearch/faiss.git
pushd faiss > /dev/null
cp example_makefiles/makefile.inc.Mac.brew makefile.inc
make -j8 -s
rm -rf ../../../libs/FAISS/lib/osx/*
rm -rf ../../../libs/FAISS/include/*
mkdir -p ../../../libs/FAISS/lib/osx/
mkdir -p ../../../libs/FAISS/include/faiss/
cp *.h ../../../libs/FAISS/include/faiss
cp libfaiss.a ../../../libs/FAISS/lib/osx/
popd > /dev/null
popd > /dev/null

