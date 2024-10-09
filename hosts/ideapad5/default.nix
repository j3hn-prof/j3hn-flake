{ inputs, ... }:

{
	imports = [
		# Template settings
		../templates/desktop.nix

		# App configurations
		../modules/app

		# Hardware configurations
		./hardware-configuration.nix
		inputs.hardware.nixosModules.lenovo-ideapad-slim-5
	];
}
