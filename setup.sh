#!/bin/bash

cwd=`pwd`
ext=$cwd/ext_module
export PERL6LIB="$cwd,$cwd/p6src,$cwd/p6lib,$ext/PackUnpack"
