#!/bin/bash

export TOPSRCDIR="$(stat -f %N ..)"
echo $TOPSRCDIR
./_dist_run
