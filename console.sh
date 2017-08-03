#!/bin/bash

function build
{
    docker build -t luanlmd/cordova .
}

function bash
{
    docker run -it --rm luanlmd/cordova bash
}

function cordova
{
    docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD/src:/src luanlmd/cordova cordova $1 $2 $3 $4
}

function aliases
{
    echo "alias cordova='docker run -it --rm --privileged --expose 8000 -p 8000:8000 -v /dev/bus/usb:/dev/bus/usb -v \$PWD:/src luanlmd/cordova cordova'" >> ~/.bash_aliases
    source ~/.bash_aliases
}

$1 $2 $3 $4 $5
