#!/usr/bin/env bash

git clone https://github.com/timescale/timescaledb.git

cd timescaledb

git checkout 1.7.4

./bootstrap

cd build && make

make install