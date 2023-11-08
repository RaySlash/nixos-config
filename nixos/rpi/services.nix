{ config, pkgs, lib, inputs, outputs, ...}: {

  services = {
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
    };
  };
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    enableCompletion = true;
    histSize = 10000;
    ohMyZsh = {
      enable = true;
      theme = "mortalscumbag";
    };
    shellAliases = {
      ls = "exa --icons";
      ll = "exa --icons -l";
      vim = "nvim";
      nix-update = "sudo nixos-rebuild switch";
    };
  };
}
