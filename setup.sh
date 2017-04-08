#!/bin/bash

source .config

ROOT=$(pwd)
DOWNLOAD_DIR=./.download
MODULES_DIR=./modules


function isEnvProper() {
    local isProper=0
    
    declare -a dependencies=(cmake) 

    for dep in ${dependencies[@]}; do
        if [ -z $(which ${dep}) ]; then
            echo "${dep} is not available!"
            isProper=1
        fi
    done

    return isProper
}

function createDirectories() {
    mkdir ${DOWNLOAD_DIR}
    mkdir ${MODULES_DIR}
}

function downloadModule() {
    name="${1}"
    declare -A urls=(
        ["gtest"]="https://github.com/google/googletest/archive/release-1.8.0.tar.gz"
        ["boost"]="https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz"
    )

    url="${urls[$name]}"
    echo "Downloading ${name}"
    wget ${url} -P ${DOWNLOAD_DIR}/${name} 
}

function installModule() {
    name="${1}"

    declare -A installCommands=(
        ["gtest"]=installGtest
        ["boost"]=installBoost
    )

    echo "Installing ${name}"
    ${installCommands[${name}]}
}

function installGtest() {
    tar -xf ${DOWNLOAD_DIR}/gtest/*.tar.gz -C ${MODULES_DIR}
}

function installBoost() {
    tar -xf ${DOWNLOAD_DIR}/boost/*.tar.gz -C ${MODULES_DIR}
    cd ${MODULES_DIR}/boost
    ./bootstrap.sh --show-libraries

    cd ${ROOT}
}

if [ isEnvProper ]; then
    createDirectories
    downloadModule "gtest"
    downloadModule "boost"
    installModule "gtest"
    installModule "boost"
fi
