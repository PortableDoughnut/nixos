{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
    home.packages = with pkgs; [
        catppuccin-cursors.mochaMauve
        catppuccin-qt5ct
    ];

    home.pointerCursor = {
        # Enable cursor theme for both X11 and GTK
        x11.enable = true;
        gtk.enable = true;

        # Package selection: replace "mochaMauve" with your accent (e.g., mochaBlue, mochaSapphire)
        package = pkgs.catppuccin-cursors.mochaMauve;

        # IMPORTANT: Use lowercase theme name (changed in v0.2.1+)
        name = "catppuccin-mocha-mauve-cursors"; # Adjust accent to match your choice

        # Set your preferred cursor size
        size = 24;
    };

    home.sessionVariables = {
        XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
        XCURSOR_SIZE = "24";
        NIXOS_OZONE_WL = "1"; # for Electron apps on Wayland
        WLR_NO_HARDWARE_CURSORS = "1"; # NVIDIA workaround
    };
}
