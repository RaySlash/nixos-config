{ config, pkgs, lib, inputs, outputs, ...}: {

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
      windowManager.dwm = {
        enable = true;
        # package = pkgs.dwm.override {
        #   patches = [
        #   (pkgs.fetchpatch {
        #     url = "https://dwm.suckless.org/patches/dwm-systray-6.4.diff";
        #     hash = "";
        #   })
        #   ];
        # };
      };
      displayManager.gdm.enable = true;
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
      theme = "robbyrussell";
    };
    shellAliases = {
      ls = "exa --icons";
      ll = "exa --icons -l";
      vim = "nvim";
      nix-update = "sudo nixos-rebuild switch";
    };
  };
}
