# All variables and this file are optional, if they are not present the PG and the
# makefiles will try to parse the correct values from the file system.
#
# Variables that specify exclusions can use % as a wildcard to specify that anything in
# that position will match. A partial path can also be specified to, for example, exclude
# a whole folder from the parsed paths from the file system
#
# Variables can be specified using = or +=
# = will clear the contents of that variable both specified from the file or the ones parsed
# from the file system
# += will add the values to the previous ones in the file or the ones parsed from the file
# system
#
# The PG can be used to detect errors in this file, just create a new project with this addon
# and the PG will write to the console the kind of error and in which line it is

meta:
	ADDON_NAME = ofxFAISS
	ADDON_DESCRIPTION = An faiss wrapper.
	ADDON_AUTHOR = Christopher Baker
	ADDON_TAGS = "computer vision" "machine learning" "vector search"
	ADDON_URL = http://github.com/bakercp/ofxFAISS

common:
	# dependencies with other addons, a list of them separated by spaces
	# or use += in several lines
	# ADDON_DEPENDENCIES =

	# include search paths, this will be usually parsed from the file system
	# but if the addon or addon libraries need special search paths they can be
	# specified here separated by spaces or one per line using +=
	#ADDON_INCLUDES = libs/dlib/include

	# any special flag that should be passed to the compiler when using this
	# addon
	ADDON_CFLAGS = -O2 -Wno-strict-aliasing -fopenmp

	# any special flag that should be passed to the linker when using this
	# addon, also used for system libraries with -lname
	#ADDON_LDFLAGS = -Llibs/dlib/lib/ -ldlib
	#ADDON_LDFLAGS = -ldlib

	# linux only, any library that should be included in the project using
	# pkg-config
	# ADDON_PKG_CONFIG_LIBRARIES =

	# osx/iOS only, any framework that should be included in the project
	# ADDON_FRAMEWORKS =

	# source files, these will be usually parsed from the file system looking
	# in the src folders in libs and the root of the addon. if your addon needs
	# to include files in different places or a different set of files per platform
	# they can be specified here
	#ADDON_SOURCES = src/%

	# some addons need resources to be copied to the bin/data folder of the project
	# specify here any files that need to be copied, you can use wildcards like * and ?
	# ADDON_DATA = models/

	# when parsing the file system looking for libraries exclude this for all or
	# a specific platform
	# ADDON_LIBS_EXCLUDE =

	# when parsing the file system looking for sources exclude this for all or
	# a specific platform
	# ADDON_SOURCES_EXCLUDE = libs/dlib/include/%

	# when parsing the file system looking for include paths exclude this for all or
	# a specific platform
	# ADDON_INCLUDES_EXCLUDE = libs/dlib/include/%

	# ADDON_INCLUDES = libs/dlib/include
	# ADDON_INCLUDES += libs/ofxDlib/include
	# ADDON_INCLUDES += src

osx:
	# These are essentially copied from the example makefile.inc.brew included with FAISS.
	CC=/usr/local/opt/llvm/bin/clang
	CXX=/usr/local/opt/llvm/bin/clang++
	ADDON_CFLAGS+=-fPIC -m64 -Wall -g -O3 -msse4 -mpopcnt -fopenmp -Wno-sign-compare -Dnullptr=NULL -I/usr/local/opt/llvm/include -Doverride=
	ADDON_LDFLAGS+=-g -fPIC -fopenmp -L/usr/local/opt/llvm/lib

	# Experimental CUDA Support for OSX (it's not working)
	# ADDON_INCLUDES+= /usr/local/cuda/include
	# ADDON_LDFLAGS+=-L/usr/local/cuda/lib -lcudart_static -lcublas_static

linux64:
	ADDON_CFLAGS+=-fPIC -m64 -Wall -g -O3  -msse4 -mpopcnt -fopenmp -Wno-sign-compare -fopenmp
	ADDON_LDFLAGS+=-g -fPIC  -fopenmp

	ADDON_PKG_CONFIG_LIBRARIES+=blas lapack

	# If faiss compiled with CUDA support, you made need to include these.
	ADDON_INCLUDES += /usr/local/cuda/include
	ADDON_LDFLAGS+=-L/usr/local/cuda/lib64 -lcuda -lcudart -lcublas -lcurand -lcusolver

	# If faiss is compiled with MKL support, you may need to add an include here.
	# ADDON_INCLUDES+=/opt/intel/mkl/include

