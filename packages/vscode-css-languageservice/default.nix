{
  mkDerivation,
  fetchFromGithub,
  lib,
  nodejs,
  ...
}:
mkDerivation {
  pname = "vscode-css-languageservice";
  version = "6.3.2";

  src = fetchFromGithub {
    owner = "microsoft";
    repo = "vscode-css-languageservice";
    rev = "tags/v6.3.2";
    hash = lib.fakeSha256;
  };

  nativeBuildInputs = [nodejs];
  buildInputs = [];

  buildPhase = ''
  '';

  meta = {
    description = "CSS, LESS & SCSS language service extracted from VSCode to be reused, e.g in the Monaco editor.";
    homepage = "https://github.com/microsoft/vscode-css-languageservice";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [rayslash];
  };
}
