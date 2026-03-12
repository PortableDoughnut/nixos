{
config,
pkgs,
inputs,
lib,
...
}:

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
        p7zip
        python313Packages.tkinter
        rust-analyzer
        typescript-language-server
        lua-language-server
        nodePackages.prettier
        nodePackages.typescript-language-server
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
