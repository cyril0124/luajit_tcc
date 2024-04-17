# luajit_tcc

## Requirements
LuaJIT 2.1

## Usage
```bash
make init

make

source setvars.sh # This will setup LuaPackagePath.

lua example.lua # for more examples, please visit https://github.com/nucular/tcclua
```

## tcc.lua

Source code is copy from https://github.com/nucular/tcclua with slightly modify

1. upgrate TCC_VERSION from "0.9.26" to "0.9.27".
2. custom install path can be set using tcc.install_dir.
3. fix some typo.

