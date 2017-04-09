#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh BIN_PATH_INSTALLATION"
    exit 0
fi

if [ ! -e "$1" ]; then
    echo "$1" doesn't exist!'
    exit 0
fi

echo "Installing cpp-boostrap to $1"
cp cpp-bootstrap $1/

echo "Copying templates to ${HOME}/.cpp-bootstrap"
mkdir -p ~/.cpp-bootstrap
cp -r templates/* ~/.cpp-bootstrap/
