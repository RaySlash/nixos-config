# NixOS dotfiles
This repository consists of my personal NixOS configuration files. This is a flake repository. You know what to do!

```shell
git clone https://github.com/RaySlash/nixos-config && cd nixos-config
rm flake.lock */"replace_with_hostname"/hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix nixos/"replace_with_hostname"/
sudo nixos-rebuild boot --flake .#"replace_With_hostname"

```

## Users/Hostnames
`frost`: x86_64

`rpi`: aarch64

## Credits
 [github:Misterio77/nix-starter-config](https://github.com/Misterio77/nix-starter-configs)
 
 [NixOS Wiki](https://nixos.wiki/)

 [Hyprland Wiki](https://wiki.hyprland.org/)
