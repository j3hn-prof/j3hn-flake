{ config, pkgs, lib, inputs, ... }:

let nixSysConsts = config.nixSysConsts; in
{
	options = {
		nixSysConsts = {
			userName = lib.mkOption { type = lib.types.nonEmptyStr; };
			sysName = lib.mkOption { type = lib.types.nonEmptyStr; };
			sysVer = lib.mkOption { type = lib.types.nonEmptyStr; };
			shellPkg = lib.mkOption { type = lib.types.nonEmptyStr; };
		};
	};
	config = {
		system.stateVersion = lib.mkDefault "${nixSysConsts.sysVer}";
		nix.settings.experimental-features = ["nix-command" "flakes"];
		# System timezone
		services.automatic-timezoned.enable = true;
		# Bootloader configuration
		boot.loader.efi.canTouchEfiVariables = true;
		boot.loader.grub = {
			enable = true;
			devices = [ "nodev" ];  # No specific device for UEFI
			efiSupport = true;
			efiInstallAsRemovable = false;
			useOSProber = true;
		};
		# I use zsh btw
		environment.shells = [ pkgs.${nixSysConsts.shellPkg} ];
		users.defaultUserShell = pkgs.${nixSysConsts.shellPkg};
		programs.${nixSysConsts.shellPkg}.enable = true;
		# User configuration
		users.users.${nixSysConsts.userName} = {
			isNormalUser = true;
			description = "Primary user";
			extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.${nixSysConsts.shellPkg};
		};
		# Networking configuration
		networking = {
			hostName = "${nixSysConsts.sysName}";
			networkmanager.enable = true;
		};
		# Define system packages
		environment.systemPackages = with pkgs; [
			# Development tools
			git
			wget
			# System utilities
			neofetch
			htop
			ranger
			# Editor
			neovim
		];
	};
}
