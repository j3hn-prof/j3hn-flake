{ inputs, ... }:

{
	inputs = {
		nixvim.url = "github:nix-community/nixvim";
		nixvim.inputs.nixpkgs.follows = inputs.nixpkgs;
	};
}
