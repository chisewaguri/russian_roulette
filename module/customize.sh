#!/bin/sh
# customize.sh
# this is part of russian roulette

SKIPUNZIP=0
MODDIR="/data/adb/modules/roulette"
PERSIST_DIR="/data/adb/roulette"

# exit when MODPATH is undefined
[ -z "$MODPATH" ] && { echo "ERROR: MODPATH is undefined"; exit 1; }

# create persistent directory if it doesn't exist
mkdir -p "$PERSIST_DIR"

# EOF
