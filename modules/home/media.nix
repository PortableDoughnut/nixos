{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
    home.packages = with pkgs; [
        freetube
        rmpc
        vlc
        lrcget
        krita
        zathura
        tui-journal
        davinci-resolve
        castero
        tt
    ];
}
