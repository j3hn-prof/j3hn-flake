{ config, pkgs, lib, inputs, ... }:

let
	name = "j3hn";
	sysName = "device";
	sysVer = "24.11";
	shellPkg = "zsh";
in
{
	config = {
		system.stateVersion = lib.mkDefault sysVer;
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
		environment.shells = [ pkgs.${shellPkg} ];
		users.defaultUserShell = pkgs.${shellPkg};
		programs.${shellPkg}.enable = true;
		# User configuration
		users.users.${name} = {
			isNormalUser = true;
			description = "Primary user";
			extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.${shellPkg};
		};
		# Networking configuration
		networking = {
			hostName = sysName;
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
