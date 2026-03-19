{ config
, pkgs
, inputs
, lib
, ...
}:

{
  home.packages = with pkgs; [
    steam-run
    steamcmd
    wineWow64Packages.waylandFull
    bottles
    mindustry
    openttd
    luanti
    nethack
    lincity-ng
    xonotic
    freeciv
    armagetronad
    endless-sky
    ringracers
    supertuxkart
    wesnoth
    freedink
    shattered-pixel-dungeon
    protontricks
    protonup-qt
  ];
}
