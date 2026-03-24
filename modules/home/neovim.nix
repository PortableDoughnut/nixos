{ config
, pkgs
, inputs
, lib
, ...
}:

{
  home.packages = with pkgs; [
    catppuccin-kde
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })
    tree-sitter
    pyrefly
    ripgrep
    fd
    nodejs
    perl
    ruby
    vimPlugins.trouble-nvim
    kotlin-language-server
    starship
    kitty
    ranger
    nixfmt
    libremines
    euphonica
    catppuccin-kde
  ];
}
