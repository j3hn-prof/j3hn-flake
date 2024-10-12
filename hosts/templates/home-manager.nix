{ lib, config, inputs, ... }:

let nixSysConsts = config.nixSysConsts; in
{
	options = {
		nixSysConsts.userName = lib.mkOption { type = lib.types.nonEmptyStr; };
		nixSysConsts.sysVer = lib.mkOption { type = lib.types.nonEmptyStr; };
	};
	imports = [ inputs.home-manager.nixosModules.home-manager ];
	config = {
		home-manager.users."${nixSysConsts.userName}" = {
			programs.home-manager.enable = true;
			home.stateVersion = nixSysConsts.sysVer;
		};
	};
}
