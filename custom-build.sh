#!/bin/bash
cd project
source ./env.sh

cmake -DCMAKE_BUILD_TYPE=Debug .
make

