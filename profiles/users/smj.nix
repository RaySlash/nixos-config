{ pkgs, ... }: {
  users.users = {
    smj = {
      isNormalUser = true;
      extraGroups =
        [ "wheel" "podman" "docker" "audio" "video" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };

}
