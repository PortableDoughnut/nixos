{ config, lib, inputs, pkgs, ... }:

{
	home.packages = with pkgs; [
		abcde
		cdparanoia
		eject
		picard
		handbrake
		makemkv
	];
}
