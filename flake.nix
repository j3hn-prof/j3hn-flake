{
	description = "j3hn's personal flake for NixOS configs given a system";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		hardware.url = "github:NixOS/nixos-hardware/master";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix";
		stylix.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { nixpkgs, home-manager, ... } @ inputs:

	let
		lib = nixpkgs.lib;
		# Function to create new system configurations
		defSys = { hostName, arch ? "x86_64-linux" }: lib.nixosSystem {
			system = arch;
			specialArgs = { inherit inputs hostName; };
			modules = [
				./hosts/${hostName}
			];
		};

	in {
		nixosConfigurations = {
			ideapad5 = defSys { hostName = "ideapad5"; };
			# desktop = defSys { hostName = "desktop"; };
			wm = defSys { hostName = "wm"; };
		};
	};
}

