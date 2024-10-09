{ inputs, config, pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
/*		programs.zsh.promptInit = "
		PROMPT=\"%F{cyan}%f %B%F{cyan}%d%f%b %F{red}%f %F{green}󰥔%f %B%F{green}%T%f %B%F{magenta}>%f \"
		";
*/		shellAliases = {
			e = "nvim";
			se = "sudo nvim";
			cr = "clear";
			rebuildDef = "sudo nixos-rebuild switch --flake $HOME/nixos#default --option eval-cache false";
			bmount = "zsh $HOME/nixos/scripts/better_mount.sh";
			fumount = "sudo umount $HOME/Mount";
		};

		history.size = 100;
	};
}
