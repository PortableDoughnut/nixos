{ inputs, config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];  # from installer
  nixpkgs.config.allowUnfree = true;           # allow non-free (NVIDIA, Steam, etc.)

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System‑wide packages (libraries, tools needed by root or multiple users)
  environment.systemPackages = with pkgs; [
    # Low‑level libraries and essential tools
    libxcb
    libxcb-util
    libxcb-cursor
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm
    wl-clipboard
    kdePackages.plasma-workspace      # KDE core
    kdePackages.qtwebsockets           # KDE dependency
    kdePackages.polkit-kde-agent-1     # Polkit agent for KDE
    libaacs                            # Blu‑ray library
    libbdplus                           # Blu‑ray library
    vim                                 # emergency editor for root
    nixos-artwork.wallpapers.catppuccin-mocha
    catppuccin
    catppuccin-kde
    catppuccin-gtk
    catppuccin-sddm
    catppuccin-grub
    catppuccin-plymouth
    wget                                # download tool for system scripts
    unrar                               # maybe needed by system services
    p7zip                               # maybe needed by system services
    mpd
    pulseaudio
    (python3.withPackages (ps: with ps; [ websockets pynvim ]))  # if any system service uses it
  ];
    
        programs.git = {
        enable = true;
            config = {
                user = {
                    name  = "Gwen Thelin";
                    email = "gwen.thelin@proton.me";
                };
            init.defaultBranch = "main";
        };
    };

    
    services.mpd = {
        enable = true;
        user = "gwen";
  
        settings = {
            music_directory = "/shared/Garnet/Music";
            audio_output = [
                {
                    type = "pulse";
                    name = "PipeWire (PulseAudio)";
                }
            ];
        };
    };

    systemd.services.mpd.environment = {
        PULSE_RUNTIME_PATH = "/run/user/1000/pulse/";
    };

    services.mpdscribble = {
        enable = true;
        endpoints = {
            "last.fm" = {
                url = "https://post.audioscrobbler.com/";
                username = "PortableDonut";
                passwordFile = "/etc/mpdscrobble-password";
            };
        };
    };
    
    # Zoxide
    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    # Starship
    programs.starship = {
        enable = true;
    };

    # Direnv
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    xdg.portal = {
        enable = true;

        extraPortals = with pkgs; [
            kdePackages.xdg-desktop-portal-kde
        ];

        configPackages = with pkgs; [
            kdePackages.xdg-desktop-portal-kde
        ];

    };

	environment.sessionVariables = {
		ELECTRON_OZONE_PLATFORM_HINT = "wayland";
	};

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
  };

  boot.plymouth = {
    enable = true;
    # The package catppuccin-plymouth needs to be available.
    # You might need to add it to your nixpkgs config or fetch it directly.
    themePackages = [ 
      (pkgs.catppuccin-plymouth.override {
        variant = "mocha"; # Or your preferred flavour: latte, frappe, macchiato
      })
    ];
    theme = "catppuccin-mocha"; # Must match the override name
  };

  services.udisks2.enable = true;

  nixpkgs.config.permittedInsecurePackages = [ # needed until new stremio frontend is stable
    "qtwebengine-5.15.19"
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-runtime-6.0.36"
  ];

  fonts = {
    packages = with pkgs; [
      maple-mono.NF
    ];
    enableDefaultPackages = true;
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = ["root" "gwen"];
  };

  hardware.nvidia = {
    open = true; # use open-source kernel module
    nvidiaSettings = true;
    powerManagement.enable = true;
  };

  programs.zsh.enable = true;  # makes zsh available system‑wide (users can still choose it)
  
  hardware.steam-hardware.enable = true;


  # 4. Per‑user symlinks are now handled by Home Manager (systemd.user service moved to home.nix)

  users.users.gwen = {
    isNormalUser = true;
    description = "Gwen Thelin";
    home = "/home/gwen";
    extraGroups = [
      "wheel"        # sudo
      "networkmanager"
      "audio"
      "video"
      "input"
      "lp"
      "scanner"
    ];
    shell = pkgs.zsh;
  };

  users.users.josephine = {
    isNormalUser = true;
    description = "Josephine";
    home = "/home/josephine";
    extraGroups = [
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    shell = pkgs.bash;
  };

    
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
    };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
    };

  users.mutableUsers = true;

  # Enable sudo for wheel users
  security.sudo.wheelNeedsPassword = true;

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.wayland.enable = true;
    flatpak.enable = true;
  };

  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

  # User‑specific environment variables have been moved to home.nix

  security.polkit.enable = true;

  # ----------------------------------------
  # Bootloader (UEFI with systemd-boot)
  # ----------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.udev.extraRules = ''
    # Optical drives
    SUBSYSTEM=="block", ENV{ID_CDROM}=="?*", GROUP="cdrom"
    SUBSYSTEM=="block", ENV{ID_CDROM_DVD}=="?*", GROUP="cdrom"
    SUBSYSTEM=="block", ENV{ID_CDROM_BD}=="?*", GROUP="cdrom"
    
    # Generic SCSI devices (for some external drives)
    KERNEL=="sg[0-9]*", GROUP="cdrom", MODE="0660"
  '';

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.AUTH_SELF_KEEP;
      }
    });
  '';

  system.activationScripts.makemkv = ''
    mkdir -p /usr/lib
    ln -sf ${pkgs.libaacs}/lib/libaacs.so.0 /usr/lib/libaacs.so.0 || true
    ln -sf ${pkgs.libbdplus}/lib/libbdplus.so.0 /usr/lib/libbdplus.so.0 || true
  '';



  # ----------------------------------------
  # Networking
  # ----------------------------------------
  networking.networkmanager.enable = true;

  # ----------------------------------------
  # Sound: PipeWire (Pulse and ALSA replacement)
  # ----------------------------------------
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ----------------------------------------
  # Graphics & GPU drivers
  # ----------------------------------------
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.graphics.extraPackages = with pkgs; [
    nvidia-vaapi-driver
    libvdpau-va-gl
  ];

  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
    libva
    libvdpau-va-gl
  ];

  # ----------------------------------------
  # Other recommended options (localization, etc.)
  # ----------------------------------------
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  system.stateVersion = "26.05";
}
