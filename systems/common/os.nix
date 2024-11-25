{ pkgs, inputs, ... }: {
  imports =
    [ ../../profiles/users/smj.nix inputs.home-manager.nixosModules.default ];

  nixpkgs = {
    overlays = [ inputs.self.overlays.unstable ];
    config = { allowUnfree = true; };
  };

  home-manager.users = { smj = import ./hm.nix; };
  networking.networkmanager.enable = true;
  systemd.extraConfig = "\n    DefaultTimeoutStopSec=10s\n    ";
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs = { git.enable = true; };

  custom = {
    zsh.enable = true;
    homemanager.enable = true;
    nix.enable = true;
    themes.enable = true;
  };

  boot.tmp.cleanOnBoot = true;
  documentation.man = {
    enable = true;
    generateCaches = true;
  };

  environment = { systemPackages = with pkgs; [ eza libclang gcc gnumake ]; };

}
