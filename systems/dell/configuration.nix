{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    # inputs.home-manager.nixosModules.home-manager
    # inputs.self.nixosModules.hyprland-custom
    # ./hardware-configuration.nix
  ];

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = { smj = import ./home; };
  # };

  networking.hostName = "dell";
  hardware.pulseaudio.enable = false;
  # nixpkgs.config.nvidia.acceptLicense = true;

  boot = {
    initrd.kernelModules = ["wl"];
    kernelModules = ["wl"];
    extraModulePackages = with config.boot.kernelPackages; [
      broadcom_sta
      # nvidia_x11_legacy470
    ];
  };

  hardware.graphics.enable32Bit = true;

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 6;
    efi.canTouchEfiVariables = true;
  };

  # hardware = {
  #  nvidia = {
  #  modesetting.enable = true;
  #     powerManagement.enable = false;
  #     powerManagement.finegrained = false;
  #     open = false;
  #     nvidiaSettings = true;
  #     package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  #     prime = {
  #       sync.enable = true;
  #       intelBusId = "PCI:0:2:0";
  #       nvidiaBusId = "PCI:8:0:0";
  #     };
  #   };
  # };

  services = {
    openssh.enable = true;
    fstrim.enable = true;
    kanata = {
      enable = true;
      keyboards = {
        "v1".config = "\n              (defsrc\n                grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc\n                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \n                caps a    s    d    f    g    h    j    k    l    ;    '    ret\n                lsft z    x    c    v    b    n    m    ,    .    /    rsft\n                lctl lmet lalt           spc            ralt rmet rctl\n              )\n              \n              (deflayer colemak\n                grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc\n                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \n                esc  a    s    d    f    g    h    j    k    l    ;    '    ret\n                lsft z    x    c    v    b    n    m    ,    .    /    rsft\n                lctl lmet lalt           spc            ralt rmet rctl\n              )\n            ";
      };
    };
    # displayManager.sddm = {
    #   enable = true;
    #   wayland.enable = true;
    #   theme = "chili";
    #   settings = { Theme = { CursorTheme = "macOS-Monterey-White"; }; };
    # };
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  programs = {
    java.enable = true;
    dconf.enable = true;
    hyprland-custom.enable = true;
    kdeconnect.enable = true;
    yazi.enable = true;
  };

  environment = {systemPackages = with pkgs; [kanata];};

  system.stateVersion = "23.05";
}
