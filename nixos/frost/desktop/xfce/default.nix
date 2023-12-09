{ configs, lib, pkgs, outputs, inputs, ... }: {

  services.xserver = {
    desktopManager.xfce = {
      enable = true;
    };
  };

  environment.xfce.excludePackages = with pkgs.xfce; [
    orage
      ristretto
      mousepad
      xfburn
      parole
  ];
}
