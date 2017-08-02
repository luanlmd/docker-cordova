#!/bin/bash

function build
{
    docker build -t cordova .
}

function bash
{
    docker run -it --rm cordova bash
}

function cordova
{
    docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD/src:/src cordova cordova $1 $2 $3 $4
}

function run
{
    cordova run android --device
}

function aliases
{
    echo "alias cdv='docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v \$PWD:/src cordova cordova'" >> ~/.bash_aliases
    echo "alias cdvbash='docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v \$PWD:/src cordova bash'" >> ~/.bash_aliases
    source ~/.bash_aliases
}

$1 $2 $3 $4 $5
