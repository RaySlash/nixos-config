{ stdenv, lib, pkgs, ... }:{

stdenv.mkDerivation (finalAttrs: {
  pname = "dwm-luke";
  version = "1.0";

  src = lib.fetchFromGitHub {
    owner = "RaySlash";
    repo = "dwm-lukepi";
    rev = "master";
    hash = "";
  };

  buildInputs = [ libX11 libXinerma libXft ];

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];

  meta = {
    description = "DWM Luke patched";
    homepage = "RaySlash";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ "rayslash" ];
  };
})

}
