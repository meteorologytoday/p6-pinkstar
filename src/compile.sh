#!/bin/bash

gcc -o print_const.out print_const.c
gcc -shared -fPIC -o libp6rawsocket.so p6rawsocket.c

./print_const.out > ./SOCKET_CONSTANTS.pm
