# ofxFAISS
An openFrameworks addon for FAISS - "efficient similarity search and clustering of dense vectors."

## Installation
### OSX

#### Development Environment
FAISS requires [OpenMP](http://www.openmp.org/) support. At the time of writing, Xcode does not support [OpenMP](http://www.openmp.org/), but the latest version of LLVM does support it. The recommended way to install llvm is via [Homebrew](https://brew.sh/). After installing [Homebrew](https://brew.sh/), you should run `brew install llvm`.

#### Compile the FAISS Library
From the `scripts/` directory, run `./install_faiss_osx.sh`.

#### Configure Xcode to Use LLVM
1. In `Build Settings`, press the large `+` button and select `Add User-Defined Setting`.
2. Enter `CC` for the key and `/usr/local/opt/llvm/bin/clang` for the value.
3. In `Build Settings`, press the large `+` button and select `Add User-Defined Setting`.
4. Enter `CXX` for the key and `/usr/local/opt/llvm/bin/clang++` for the value.

#### Configure Makefiles to Use LLVM
The `addons_config.mk` file already specifies the correct values for CC and CXX on OSX.

# Troubleshooting

## OSX
```
unsupported option '-fopenmp'
```
Make sure you installed `llvm` via home brew AND you set the User Defined `CC` and `CXX` variables in Xcode (see above).