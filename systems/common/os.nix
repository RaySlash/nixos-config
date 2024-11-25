{ pkgs, inputs, ... }: {
  imports = [ ../../profiles/users/smj.nix ../../profiles/programs ];

  nixpkgs = {
    overlays = [ inputs.self.overlays.unstable ];
    config = { allowUnfree = true; };
  };

  networking.networkmanager.enable = true;
  systemd.extraConfig = "\n    DefaultTimeoutStopSec=10s\n    ";
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  services = {
    pipewire = {
      enable = true;
      package = pkgs.unstable.pipewire;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs = {
    git.enable = true;
    zsh-custom.enable = true;
  };

  boot.tmp.cleanOnBoot = true;
  documentation.man = {
    enable = true;
    generateCaches = true;
  };

  environment = { systemPackages = with pkgs; [ eza libclang gcc gnumake ]; };

}
