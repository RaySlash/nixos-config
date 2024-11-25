{ lib, fetchFromGitHub, rustPlatform, installShellFiles, makeWrapper, ... }: {

rustPlatform.buildRustPackage = {
  pname = "typstudio";
  version = "v0.1.0-preview";

  src = fetchFromGitHub {
    owner = "Cubxity";
    repo = "typstudio";
    rev = "05b05388d690840e35574f67b908ec80658317f3";
    hash = "sha256-/VR0CT37gk/MCfscizCGEsLvL6SxYuKHriaEMfHFz/Q=";
  };

  nativeBuildInputs = [
    jq
    nodejs
    nodePackages.pnpm
    installShellFiles
    makeWrapper
  ];

  preInstall = "
    local conf=src-tauri/tauri.conf.json
	  jq '.tauri.bundle.active |= false' "$conf" | sponge "$conf"
    pnpm install --frozen-lockfile
    export RUSTUP_TOOLCHAIN=stable
    cargo fetch --locked --target "$CARCH-unknown-linux-gnu" --manifest-path src-tauri/Cargo.toml
  ";

  installFlags = "
    export RUSTUP_TOOLCHAIN=stable
    export CARGO_TARGET_DIR=target
    cargo-tauri build
  ";

  meta = with lib; {
    description = "A W.I.P desktop application for a new markup-based typesetting language, typst. Typstudio is built using Tauri.";
    homepage = "https://github.com/Cubxity/typstudio";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.rayslash ];
  };
}
