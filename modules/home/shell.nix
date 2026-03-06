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
        gcc
        p7zip
        unzip
        unrar
        syncthing
        rustc
        cava
    ];

    home.file.".p10k.zsh".source = ../../hosts/default/p10k.zsh;
}
