{ config, lib, pkgs, inputs, outputs, ... }:{

networking.firewall.enable = false;
virtualisation.podman = {
  enable = true;
  dockerCompat = true;
  dockerSocket.enable = true;
  defaultNetwork.settings = {
    dns_enabled = true;
  };
  autoPrune = {
    enable = true;
    dates = "weekly";
    flags = [ "--all" ];
  };
};

  environment = {
    systemPackages = with pkgs; [
      podman-compose
      podman-tui
    ];
  };
}
