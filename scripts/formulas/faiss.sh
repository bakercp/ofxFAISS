#! /bin/bash

# tools for git use
GIT_URL="https://github.com/facebookresearch/faiss.git"
GIT_TAG=281683100ac7f44d3da983f1a7dc382ff75ca938

FORMULA_TYPES=( "osx" "linux64")

function download() {
  echo "download wd: `pwd`"
  git clone $GIT_URL
  cd faiss
  git checkout $GIT_TAG
  cd ..
}

function prepare() {
  echo "prepare wd: `pwd`"
  cp $ADDONS_DIR/ofxFAISS/scripts/$TYPE/makefile.inc .

  if [ -f $ADDONS_DIR/ofxFAISS/scripts/$TYPE/install.sh ] ; then
    $ADDONS_DIR/ofxFAISS/scripts/$TYPE/./install.sh
  fi

}

function build() {
  echo "build wd: `pwd`"

  make -j$PARALLEL_MAKE -s

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
  echo "clean wd: `pwd`"
  make clean
}
