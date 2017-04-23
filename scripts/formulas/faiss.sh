#! /bin/bash
#

echo "IN HERE"

# define the version
VER=

# tools for git use
GIT_URL="https://github.com/facebookresearch/faiss.git"
#GIT_TAG="v$VER"
GIT_TAG=281683100ac7f44d3da983f1a7dc382ff75ca938

FORMULA_TYPES=( "osx" "linux64")

# download the source code and unpack it into LIB_NAME
function download() {
  echo "Download"
  pwd
  git clone $GIT_URL
  cd faiss
  git checkout $GIT_TAG
  cd ..
}

# prepare the build environment, executed inside the lib src dir
function prepare() {
  echo "prepare wd: `pwd`"
  cp $ADDONS_DIR/ofxFAISS/scripts/$TYPE/makefile.inc .

  if [ -f $ADDONS_DIR/ofxFAISS/scripts/$TYPE/install.sh ] ; then
    $ADDONS_DIR/ofxFAISS/scripts/$TYPE/./install.sh
  fi

}

# executed inside the lib src dir
function build() {
  echo "build wd: `pwd`"
  export MAKEFLAGS="-j$PARALLEL_MAKE -s"
  make

  if [ "$TYPE" == "linux64" ] ; then
    cd gpu
    make
  fi
}

# executed inside the lib src dir, first arg $1 is the dest libs dir root
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

}

# executed inside the lib src dir
function clean() {
  echo "clean wd: `pwd`"
  make clean
}
