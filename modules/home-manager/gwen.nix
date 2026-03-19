{ config
, pkgs
, inputs
, lib
, ...
}:

{
  home.username = "gwen";
  home.homeDirectory = "/home/gwen";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  imports = [
    ../home/chat.nix
    ../home/games.nix
    ../home/media.nix
    ../home/shell.nix
    ../home/theme.nix
    ../home/neovim.nix
    ../home/ripping.nix
  ];

  home.packages = with pkgs; [
    librewolf
    winetricks
    libreoffice-qt6-fresh
    skrooge
    tt
    _1password-cli
    _1password-gui
    (python3.withPackages (ps: with ps; [ websockets ]))
  ];

  programs.zsh = {
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ni = "nvim";
      sni = "sudo nvim";
      nix-default = "sudo nixos-rebuild switch --flake /etc/nixos#default";
      ls = "lsd";
      ll = "ls -l";
    };

    plugins = [ "zoxide" "starship" "direnv" "powerlevel10k" ];

    history.size = 10000;
  };
}
