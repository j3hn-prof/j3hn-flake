{ inputs, ... }:

{
	imports = [
		# Template settings
		../templates/desktop.nix
		# Hardware configurations
		./hardware-configuration.nix
	];
}
