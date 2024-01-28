{
  lib,
  fetchFromGitHub,
  rustPlatform,
  autoPatchelfHook,
  wayland,
  ...
}: let
  buildDeps = with pkgs; [libnotify fontconfig libxkbcommon wayland];
in
  rustPlatform.buildRustPackage rec {
    pname = "yofi";
    inherit (cargoToml.package) version;

    src = fetchFromGitHub {
      owner = "rayslash";
      repo = "yofi";
      rev = "update-flake";
      hash = "";
    };

    cargoHash = "";

    buildInputs = buildDeps;
    runtimeDependencies = buildDeps;
    nativeBuildInputs = buildDeps;

    postFixup = ''
      patchelf $out/bin/yofi --add-rpath ${lib.makeLibraryPath buildDeps}
    '';

    checkFlags = [
      # Fail to run in sandbox environment.
      "--skip=screen::context::test"
    ];

    meta = {
      description = "A minimalist app launcher in Rust";
      homepage = "https://crates.io/crates/yofi";
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
      maintainers = with lib.maintainers; [rayslash];
      mainProgram = "yofi";
    };
  }
