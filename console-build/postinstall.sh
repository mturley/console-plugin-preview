#!/bin/sh

WD=$(pwd)

cd node_modules/console
./build.sh

cd "$PWD"