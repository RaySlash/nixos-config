{ config, pkgs, inputs, outputs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };
  environment.systemPackages = with pkgs; [ virt-manager ];

}
