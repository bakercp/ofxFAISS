## Getting Started

1.  From the `scripts/` directory ...
    -   `./bootstrap.sh`
2.  Generate project examples using Project Generator or an IDE Plugin.
    -   _On Xcode, you will need to make a few minor modifications, see below._
3.  FAISS can run on the CPU or on the GPU. If you compiled FAISS with CUDA support (e.g. on Linux), the examples prefixed with `example_*_gpu_` will work.  Examples prefixed with `example_*_cpu_` should work on any supported system.

## Developer Notes

### OSX

There are a few small modifications that must be made to use this with Xcode.

Did you get a message like _Warning: OpenMP is NOT activated"?_

FAISS requires [OpenMP](http://www.openmp.org/) support. At the time of writing, Xcode does not support [OpenMP](http://www.openmp.org/), but the latest version of LLVM does support it. The recommended way to install `llvm` is via [Homebrew](https://brew.sh/). After installing [Homebrew](https://brew.sh/), you should run `brew install llvm`. This is automatically attempted when `scripts/bootstrap.sh` is called.

#### Configure Xcode to Use LLVM
1.  In `Build Settings`, press the large `+` button and select `Add User-Defined Setting`.
2.  Enter `CC` for the key and `/usr/local/opt/llvm/bin/clang` for the value.
3.  In `Build Settings`, press the large `+` button and select `Add User-Defined Setting`.
4.  Enter `CXX` for the key and `/usr/local/opt/llvm/bin/clang++` for the value.

![Animated GIF](https://media.giphy.com/media/3o7btTvEP1NAigN54Y/giphy.gif)

Did you get a message like _clang: error: cannot specify -o when generating multiple output files_?

In Xcode 9, we have to make an additional adjustment:

In build settings > build options > Enable Index-While-Building Functionality to No

![Settings](https://i.stack.imgur.com/MIjRd.png)

-   Solution via [SO](https://stackoverflow.com/a/48717558/1518329).

Alternatively, add the following lines to the end of your `Project.xcconfig` file.

```
// These settings configure Xcode to build with LLVM and the correct settings.
CC=/usr/local/opt/llvm/bin/clang
CXX=/usr/local/opt/llvm/bin/clang++
COMPILER_INDEX_STORE_ENABLE=NO
```

#### Configure Makefiles to Use LLVM
The `addons_config.mk` file already specifies the correct values for `CC` and `CXX` on OSX.

#### Compiling FAISS for OSX with CUDA Support (TL;DR it doesn't work so far)
At the time of this writing, it doesn't seem possible because:
-   Building FAISS on OSX requires a recent version of `llvm` for OpenMP support.
-   The FAISS team doesn't have configs in place for GPU. But when they are built out the following is discovered:
    -   `nvcc` in CUDA `8.0.61` does not support the recent version of `llvm` (3.9).  You will get errors like `nvcc fatal   : The version ('30900') of the host compiler ('clang') is not supported`.
    -   `nvcc` does support Apple Clang 8.0.0 on OSX 10.12, (which one can downgrade to), but that also doesn't support OpenMP.  You will get errors like `clang: error: unsupported option '-fopenmp'`.
    -   If you try to be sneaky and and remove all references to `-fopenmp`, you'll just get unsatisfied linker errors.

Solution: Use Linux if you want GPU acceleration.

#### BLAS library selection for CPU operations

In informal tests (running `$ time faiss/tests/./demo_ivfpq_indexing `), CPU operations were _slightly_ faster using the Accelerate framework rather than using MKL. MKL flags were tuned according to [https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor/](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor/). Tests were performed on a Late 2012 Macbook Pro and 2018 Macbook Pro. In both cases, the `Accelerate.framework` was faster and far easier to work with.

### Linux

Tested and configured for Ubuntu 16.04 (Linux Mint 18.3 to be precise).

All "automatic" install scripts assume you are using a standard Ubuntu 16.04 configuration and have an NVIDIA GTX 10** (something with compute capability 6.0 or higher).

The default setup also assumes that a compatible version of CUDA is installed.  If the `scripts/./boostrap.h` script fails due to a CUDA error, CUDA can be disabled by modifying the `scripts/forumlas/faiss.sh` script and re-running `scripts/./bootstrap.sh`.

At the time of this writing, CUDA 8.0 was installed on the development machine.

#### BLAS library selection for CPU operations

In informal tests (running `$ time faiss/tests/./demo_ivfpq_indexing `), CPU operations were _significantly_ faster (50-75% faster) when using MKL rather than the standard openblas / openlapack.

To tune linking and other MKL flags, see [https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor/](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor/)

To use MKL as configured, you must add the following to access the dynamic libs.

```
LD_LIBRARY_PATH=/opt/intel/mkl/lib/intel64
```

e.g.

```
$ LD_LIBRARY_PATH=/opt/intel/mkl/lib/intel64 && make run
```
