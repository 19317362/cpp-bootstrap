#!/bin/bash

source .config


function createDirectories() {
    mkdir ./.download
    mkdir ./modules
}

function downloadModule() {
    name="${1}"
    declare -A urls=(
        ["gtest"]="https://github.com/google/googletest/archive/release-1.8.0.tar.gz"
        ["boost"]="https://github.com/boostorg/boost/archive/boost-1.63.0.tar.gz"
    )

    url="${urls[$name]}"
    echo "Downloading ${name}"
    wget ${url} -P ./.download/${name} 
}

createDirectories
downloadModule "gtest"
