{ luajit-pro
, tinycc
}:
luajit-pro.pkgs.buildLuaPackage {
  pname = "luajit-tcc";
  version = "latest";
  src = ./tcc.lua;
  dontUnpack = true;

  dontBuild = true;
  installPhase = ''
    destdir=$out/share/lua/${luajit-pro.luaversion}
    mkdir -p $destdir
    cp $src $destdir/tcc.lua
    sed -i 's,tcc.home_path = nil,tcc.home_path = "${tinycc}",g' $destdir/tcc.lua
  '';
}
