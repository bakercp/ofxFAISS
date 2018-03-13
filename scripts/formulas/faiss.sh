#! /bin/bash

# tools for git use
GIT_URL="https://github.com/facebookresearch/faiss.git"
GIT_TAG=0b1f5004ecc7309a10ea0642f91b231927c1c7dc

FORMULA_TYPES=( "osx" "linux64" )

function download() {
  echo "download wd: `pwd`"
  git clone $GIT_URL
  cd faiss
  git checkout $GIT_TAG
  cd ..
}

function prepare() {
  echo "prepare wd: `pwd`"

  if [ "$TYPE" == "osx" ] ; then
    # The Accelerate.framework is fastest on macOS. MKL is close, but more difficult to link / compile.
    # See the docs/GETTING_STARTED.md for more info.
    cp ${ADDONS_DIR}/ofxFAISS/scripts/${TYPE}/makefile.inc.accelerate makefile.inc
  else
    cp ${ADDONS_DIR}/ofxFAISS/scripts/${TYPE}/makefile.inc .
  fi

}

function build() {
  echo "build wd: `pwd`"

  make -j$PARALLEL_MAKE

  if [ "$TYPE" == "linux64" ] ; then
    cd gpu
    make
    cd -
  fi
}

function copy() {
  echo "copy wd: `pwd`"

	# headers
	if [ -d $1/include ]; then
		rm -rf $1/include
	fi

	mkdir -p $1/lib/$TYPE/
  mkdir -p $1/include/faiss/

	cp *.a $1/lib/$TYPE/
	cp *.h $1/include/faiss/

  if [ "$TYPE" == "linux64" ] ; then
    mkdir -p $1/include/faiss/gpu/utils
    cp gpu/*.a $1/lib/$TYPE/
    cp gpu/*.h $1/include/faiss/gpu
    cp gpu/utils/*.h $1/include/faiss/gpu/utils
  fi

}

function clean() {
  cd ..
  rm -rf faiss
}
