#!/usr/bin/env bash

if [ -n "$BASH_VERSION" ]; then
    script_file=$(realpath "${BASH_SOURCE[0]}")
elif [ -n "$ZSH_VERSION" ]; then
    script_file=$(realpath "$0")
else
    current_shell=$(ps -p $$ -ocomm=)
    echo -e "${YELLOW}[luajit_tcc] Warning: Unknown shell.${NC}"
    echo -e "\tAttempting to proceed, but behavior might be unpredictable."
    echo -e "\tCurrent shell seems to be: ${BOLD}$current_shell${NC}"
    script_file=$(realpath "$0")
    if [ ! -f "$script_file" ]; then
        echo -e "${RED}[verilua.sh] Error: Could not determine script path in this shell.${NC}"
        exit 1
    fi
fi

luajit_tcc_dir=$(dirname $(realpath $script_file))

export CONFIG_TCCDIR=$luajit_tcc_dir/tinycc/install

export LUA_PATH="\
$LUA_PATH\
$luajit_tcc_dir/?/?.lua;\
$luajit_tcc_dir/?.lua;\
"
