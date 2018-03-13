meta:
	ADDON_NAME = ofxFAISS
	ADDON_DESCRIPTION = An faiss wrapper.
	ADDON_AUTHOR = Christopher Baker
	ADDON_TAGS = "computer vision" "machine learning" "vector search"
	ADDON_URL = http://github.com/bakercp/ofxFAISS

common:
	# ADDON_DEPENDENCIES = ofxPoco
	ADDON_CFLAGS = -g -O3 -Wno-strict-aliasing -fopenmp
	ADDON_LDFLAGS = -g -fPIC -fopenmp

osx:
	# We have to compile with a compiler that supports openmp.
	CC = /usr/local/opt/llvm/bin/clang
	CXX = /usr/local/opt/llvm/bin/clang++

	# Includes and linker flags for the llvm compiler.
	ADDON_INCLUDES += /usr/local/opt/llvm/include
	ADDON_LDFLAGS += -L/usr/local/opt/llvm/lib

	# Optimization and other CFLAGS (in addition to those listed in common).
	ADDON_CFLAGS += -m64 -msse4 -mpopcnt

	# Experimental CUDA Support for OSX
	# ADDON_INCLUDES += /usr/local/cuda/include
	# ADDON_LDFLAGS += -L/usr/local/cuda/lib -lcudart_static -lcublas_static

	# If faiss is compiled with MKL support, you may need to add an include here.
	# In my testing, the Accelerate.framework was faster than MKL, so use
	# that by default.
	# ADDON_INCLUDES += /opt/intel/mkl
	# ADDON_LDFLAGS += /opt/intel/mkl/lib/libmkl_intel_ilp64.a /opt/intel/mkl/lib/libmkl_intel_thread.a /opt/intel/mkl/lib/libmkl_core.a -liomp5 -lpthread -lm -ldl

linux64:
	# Optimization and other CFLAGS (in addition to those listed in common).
	ADDON_CFLAGS += -m64 -msse4 -mpopcnt

	# Support for blas.
	# ADDON_PKG_CONFIG_LIBRARIES+=blas lapack

	# If faiss is compiled with MKL support, you may need to add an include here.
	ADDON_INCLUDES += /opt/intel/mkl/include
	ADDON_LDFLAGS += -L/opt/intel/mkl/lib/intel64 -lmkl_intel_ilp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -ldl


	# If faiss compiled with CUDA support, you made need to include these.
	ADDON_CFLAGS += -DFAISS_USE_GPU
	ADDON_INCLUDES += /usr/local/cuda/include
	ADDON_LDFLAGS += -L/usr/local/cuda/lib64 -lcuda -lcudart -lcublas -lcurand -lcusolver
