# Troubleshooting

## OSX

### OpenMP is NOT activated

```
unsupported option '-fopenmp'
```
Make sure you installed `llvm` via home brew AND you set the User Defined `CC` and `CXX` variables in Xcode (see [GETTING_STARTED.md](GETTING_STARTED.md)).


### Clang cannot generate multiple output files

```
_clang: error: cannot specify -o when generating multiple output files
```

In Xcode 9, we have to make a few adjustments.

In build settings > build options > Enable Index-While-Building Functionality to No

![Settings](https://i.stack.imgur.com/MIjRd.png)

-   Solution via [SO](https://stackoverflow.com/a/48717558/1518329).


## Linux

Everything is tested on Ubuntu 16.04 / Linux Mint 18.3. If you are running into compilation problems with another distribution, you may have to manually modify compiler settings to find the correct libraries, etc.
