{ config, pkgs, ... }:
{
	imports =[./hardware-configuration.nix];

	boot.loader.grub.enable = false;
	boot.loader.generic-extlinux-compatible.enable = true;

	networking.hostName = "nixos-rpi";
	networking.networkmanager.enable = true;
	networking.firewall.allowedTCPPorts = [ 80 3000 ];
	networking.firewall.allowedUDPPorts = [ 80 53 ];
	networking.firewall.enable = true;
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	time.timeZone = "Australia/Brisbane";
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		useXkbConfig = true;
	};

	users.users.smj = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
		shell = pkgs.zsh;
		packages = with pkgs; [
		tree
			];
	};

	environment.systemPackages = with pkgs; [
		nix-index
		wget
		git
		exa
		libgccjit
		libraspberrypi
		cmake
		pkg-config
		ninja
		openssl
		apacheHttpd
		adguardhome
		gnupg
	];

	programs = {
		zsh = {
			enable = true;
			ohMyZsh = {
				enable = true;
				theme = "mortalscumbag";
				plugins = [
					"sudo"
						"systemadmin"
				];
			};
			shellAliases = {
				ls = "exa --icons";
				ll = "exa --icons -l";
				vim = "nvim";
			};
		};
		neovim = {
			enable = true;
			defaultEditor = true;
		};
	};

	users.defaultUserShell = pkgs.zsh;
	programs.mtr.enable = true;
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	services.openssh.enable = true;
	services.adguardhome.enable = true;

	system.copySystemConfiguration = true;
	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";
	system.stateVersion = "23.05";
}

