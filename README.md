# cpp-bootstrap

Utility preparing environment for C++ CMake project, using Google Test and Boost libraries.

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

Additionally, script will create .cpp-bootstrap directory in your HOME and will fill it with unnecessary template files. 

## Usage
```
mkdir myproject 
cd myproject
vi .config
```
.config file is a must, it should contain this content:

```
PROJ_NAME=YOUR_PROJECT_NAME
CPP_STD=[98, 11, 14]
```

```
cpp-bootstrap
```

Some magic will happen, including compilation of Boost libraries, so be patient. 

When everything is done, you should be able to:

- run sample UT (`make ut`)
- run sample code (`make run`)
