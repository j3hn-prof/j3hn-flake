{ inputs, ... }:

{
	imports = [
		# Template settings
		../templates/desktop.nix
		../templates/home-manager.nix
		# Hardware configurations
		./hardware-configuration.nix
	];

	nixSysConsts = {
		userName = "j3hn";
		sysName = "device";
		sysVer = "24.05";
		shellPkg = "zsh";
	};
}
