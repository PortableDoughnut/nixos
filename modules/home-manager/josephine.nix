{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
    home.username = "josephine";
    home.homeDirectory = "/home/josephine";
    home.stateVersion = "26.05";

    programs.home-manager.enable = true;

    imports = [
        ../home/games.nix
    ];

    home.packages = with pkgs; [
        firefox
        libreoffice-qt6-fresh
    ];
}
