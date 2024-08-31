#!/bin/bash

current_shell=$(ps -p $$ -ocomm=)

if [[ "$current_shell" == *bash* ]]; then
    script_path=$(realpath "${BASH_SOURCE[0]}")
elif [[ "$current_shell" == *zsh* ]]; then
    script_path=$0
else
    echo "Unknown shell"
fi

luajit_tcc_dir=$(dirname $(realpath $script_path))

export CONFIG_TCCDIR=$(dirname $(realpath $script_path))/tinycc/install

export LUA_PATH="\
$LUA_PATH\
$luajit_tcc_dir/?/?.lua;\
$luajit_tcc_dir/?.lua;\
"
