{ configs, lib, pkgs, outputs, inputs, ... }: {

  services.xserver = {
    desktopManager.xfce = {
      enable = true;
    };
  };
}
