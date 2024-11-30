{pkgs, ...}: {
  devshells.default = {
    name = "nixos-config-shell";
    meta.description = "Dev Environment for nix";
    env = [
      {
        name = "EDITOR";
        value = "vim";
      }
    ];
    commands = [
      {
        ls = "eza --icons";
        nvim = "nix run gitlab:rayslash/nvim";
        nix-switch = "sudo nixos-rebuild switch --flake .";
      }
    ];
    packages = with pkgs; [git eza vim nil nixd stylua];
  };
}
