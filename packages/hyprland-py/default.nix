{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  wayland,
  hyprland,
  ...
}:
buildPythonPackage rec {
  pname = "hyprland";
  version = "0.2.54";

  src = fetchFromGitHub {
    owner = "hyprland-community";
    repo = "hyprland-py";
    rev = "${version}";
    sha256 = "sha256-Y+egKatlH9rTbxoUqcoAzHURF0X3xFd0eSJRXhBlD5g=";
  };

  propagatedBuildInputs = [wayland hyprland];

  nativeCheckInputs = [];

  meta = with lib; {
    description = "An unoffical async python wrapper for hyprland's IPC";
    homepage = "https://github.com/hyprland-community/hyprland-py";
    license = licenses.mit;
    maintainers = with maintainers; [rayslash];
  };
}
