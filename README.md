# ofxFAISS
An openFrameworks addon for FAISS - "efficient similarity search and clustering of dense vectors."

More on the library, including tutorials and lots of great documentation [here](https://github.com/facebookresearch/faiss).

## Installation

This addon repository does not include pre-compiled binary libraries, but does include the scripts to compile them yourself.

From the `scripts/` directory, run `./install.sh`.

## Examples

1. Generate project examples using Project Generator or an IDE Plugin.
  - _On Xcode, you will need to make a few minor modifications, see below._
2. FAISS can run on the CPU or on the GPU. If you compiled FAISS with CUDA support (e.g. on Linux), the examples prefixed with `example_gpu_` will work.  Examples prefixed with `example_cpu_` should work on any supported system.

## Developer Notes

### OSX

FAISS requires [OpenMP](http://www.openmp.org/) support. At the time of writing, Xcode does not support [OpenMP](http://www.openmp.org/), but the latest version of LLVM does support it. The recommended way to install llvm is via [Homebrew](https://brew.sh/). After installing [Homebrew](https://brew.sh/), you should run `brew install llvm`.

#### Configure Xcode to Use LLVM
1. In `Build Settings`, press the large `+` button and select `Add User-Defined Setting`.
2. Enter `CC` for the key and `/usr/local/opt/llvm/bin/clang` for the value.
3. In `Build Settings`, press the large `+` button and select `Add User-Defined Setting`.
4. Enter `CXX` for the key and `/usr/local/opt/llvm/bin/clang++` for the value.

![Animated GIF](https://media.giphy.com/media/3o7btTvEP1NAigN54Y/giphy.gif)

#### Configure Makefiles to Use LLVM
The `addons_config.mk` file already specifies the correct values for `CC` and `CXX` on OSX.

#### Compiling FAISS for OSX with CUDA Support (TL;DR it doesn't work so far)
At the time of this writing, it doesn't seem possible because:
- Building FAISS on OSX requires a recent version of `llvm` for OpenMP support.
- The FAISS team doesn't have configs in place for GPU. But when they are built out the following is discovered:
  - `nvcc` in CUDA `8.0.61` does not support the recent version of `llvm` (3.9).  You will get errors like `nvcc fatal   : The version ('30900') of the host compiler ('clang') is not supported`.
  - `nvcc` does support Apple Clang 8.0.0 on OSX 10.12, (which one can downgrade to), but that also doesn't support OpenMP.  You will get errors like `clang: error: unsupported option '-fopenmp'`.
  - If you try to be sneaky and and remove all references to `-fopenmp`, you'll just get unsatisfied linker errors.

Solution: Use Linux if you want GPU acceleration.

### Linux

Tested and configured for Ubuntu 16.04 (Linux Mint 18.1 to be precise).

All "automatic" install scripts assume you are using a standard Ubuntu 16.04 configuration.

The default setup also assumes that a compatible version of CUDA is installed.  If the `scripts/./install.h` script fails due to a CUDA error, CUDA can be disabled by modifying the `scripts/forumlas/faiss.sh` script and re-running `scripts/./install.sh`.

At the time of this writing, CUDA 8.0 was installed on the development machine.

# Troubleshooting

## OSX
```
unsupported option '-fopenmp'
```
Make sure you installed `llvm` via home brew AND you set the User Defined `CC` and `CXX` variables in Xcode (see above).
