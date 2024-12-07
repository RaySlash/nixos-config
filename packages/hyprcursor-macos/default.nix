{
  pkgs,
  fetchfromGithub,
  ...
}: {
  pkgs.mkDerivation {
    src = fetchfromGithub {
      pname = "";
      src = "";
      rev = "";
      hash = "";
    };
    postHook = ''
    '';
  };
}
