{ config, pkgs, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    lsd
    nvd
    mise
    direnv
    zoxide
    zsh-powerlevel9k
    cargo
    tree
    gcc
    pnpm
    tsx
    xclip
    p7zip
    python313Packages.tkinter
    rust-analyzer
    go
    typescript-language-server
    lua-language-server
    prettier
    typescript-language-server
    vscode-extensions.biomejs.biome
    vscode-langservers-extracted
    lazygit
    ast-grep
    beautysh
    pyright
    sourcekit-lsp
    lua-language-server
    nodePackages.vscode-langservers-extracted
    unzip
    unrar
    syncthing
    rustc
    cava
  ];

  home.file.".p10k.zsh".source = ../../hosts/default/p10k.zsh;
}
