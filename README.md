# cpp-bootstrap

Utility preparing environment for C++ CMake project, using Google Test and Boost libraries.

The main goal is to prepare an isolated environment with no need for root privileges. Libraries are located in the
project directory _modules_.

If you don't trust your package manager, use this script - No System Pollution™ guaranteed! (or try using Docker)

The environment will have this structure:
- CMakeLists.txt
- Makefile
- build/
- include/
- modules/
    - boost\_1\_63\_0/
    - googletest-release-1.8.0/
- src/
    - Hello.cpp
- tests/
    - HelloTest.cpp

Makefile is being used just as a top level script which wraps everything up.

## Tests
To execute script tests:
```
./tests.sh
```

## Installation
```
./install.sh BIN_DIRECTORY
```

It will copy _cpp-boostrap_ executable to BIN_DIRECTORY. Make sure BIN_DIRECTORY is in your PATH variable. 

Additionally, script will create .cpp-bootstrap directory in your HOME and will fill it with necessary template files. 

## Usage
```
mkdir myproject 
cd myproject
vi .config
```
.config file is a must, it should contain following content:

```
PROJ_NAME=YOUR_PROJECT_NAME
CPP_STD=[98, 11, 14]
```
Having .config prepared, execute:

```
cpp-bootstrap
```

Some magic will happen, including compilation of Boost libraries, so be patient. 

When everything is done, you should be able to:

- run sample UT (`make ut`)
- run sample code (`make run`)
