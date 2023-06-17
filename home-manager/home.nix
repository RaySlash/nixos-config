{ config, lib, pkgs, ... }:

{
	home.username = "smj";
	home.homeDirectory = "/home/smj";
	home.stateVersion = "23.05";
	home.packages = [
		(pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
		pkgs.htop
	];
	home.file = {};
	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.home-manager.enable = true;
	programs.git = {
		enable = true;
		userName = "RaySlash";
		userEmail = "stevemathewjoy@gmail.com";
	};
}
