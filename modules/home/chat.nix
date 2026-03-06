{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
    home.packages = with pkgs; [
        element-desktop
        signal-desktop
        telegram-desktop
        vesktop
        slack
        (discord.override { withVencord = true; })
    ];
}
