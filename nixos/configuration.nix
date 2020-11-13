# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  stable = import <nixos-stable> { config = config.nixpkgs.config; };
in {
  nixpkgs.config.allowUnfree = true; # for AndroidStudio
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Scripts for changing the brightness of the keyboard backlight
      ./keyboard_backlight_scripts.nix
      # Custom scripts (i.e. Bevuta Standup)
      ./custom_scripts.nix
      # ZSH-init
      #./zsh_config.nix
      ./vim.nix
      ./suspend_on_low_battery.nix
    ];

  nixpkgs.overlays = [
    ( import ./overlays/i3.nix )
    # ( import ./overlays/neovim.nix ) # issue with TreeSitter
  ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  systemd.services."ModemManager" = {
    enable = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0f0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  nix.gc.automatic = false;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    # UI Stuff, backlight control
    xorg.xev #actkdb #xorg.xbacklight
    xorg.xkill xorg.xorgserver xorg.xf86inputevdev xorg.xf86inputsynaptics xorg.xf86inputlibinput
    lxappearance arandr
    brightnessctl
    dmidecode
    upower lm_sensors
    # Notifications
    libnotify notify-osd # dunst
    # Screensaver
    xautolock
    # Disk usage
    ncdu gparted
    # zip
    zip unzip
    # Terminal emulator
    alacritty # termite
    # Basic shell stuff
    curl zsh oh-my-zsh htop man_db tmux screen tree wget which xclip psmisc fd file
    usbutils pciutils envsubst
    # Fuzzy file finder
    fzf

    # Neovim
    # tree-sitter

    # correcting mistakes
    thefuck
    # Networking
    nmap wirelesstools openssl
    networkmanager_dmenu
    libqmi dhcpcd
    modem-manager-gui #modemmanager
    bandwhich # which application uses bandwith

    # FileExplorer
    pcmanfm vifm
    # Browser
    firefox ungoogled-chromium #chromium #
    # Mail
    thunderbird
    # Messenger
    signal-desktop mattermost-desktop
    # Document viewers
    evince gnome3.eog
    # Image editing
    gimp inkscape imagemagick
    # Videos
    vlc ffmpeg
    # Sound
    pavucontrol
    # Documents
    libreoffice
    # LaTeX
    stable.texlive.combined.scheme-full
    # OCR
    tesseract

    # ##Programming
    gitAndTools.gitFull
    gitAndTools.tig
    ctags
    # JVM
    openjdk11 scala leiningen maven
    android-studio

    # Syntax highlighted cat
    glow
    # JS
    nodejs jq #nodePackages.node2nix #nodePackages.expo-cli nodePackages.react-native-cli
    # Python
    python3
    #python3Packages.notebook #python3Packages.pygments python3Packages.matplotlib python3Packages.numpy python3Packages.scipy

    # vimwiki => html converter
    pandoc

    # Editors
    emacs #atom


    # Others
    yad
  ];

  system.autoUpgrade = {
    enable = true;
    dates = "04:30";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # Control Backlight
  programs.light.enable = true;

  programs.adb.enable = true;

  programs.steam.enable = true;

  # List services that you want to enable:
  # USB Automounting
  services.gvfs.enable = true;  

  #services.udev.packages = [ monitor_hotplugging ];

  # Fingerprint Reader
  #services.fprintd.enable = true;
  #security.pam.services = {
  #  login.fprintAuth = true;
  #  xscreensaver.fprintAuth = true;
  #};

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  programs.ssh.startAgent = true;
  services.sshd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.bluetooth = {
    enable = true;
    config.General.ControllerMode = "bredr"; #"dual";
  };

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    autorun = true;
    layout = "de";
    #videoDrivers = [ "amdgpu" "radeon" ]; # "modesetting" ]; #amdgpu-pro
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        rofi dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
    xkbOptions = "ctrl:swapcaps";
    displayManager.lightdm.enable = true;
    #displayManager.lightdm.extraConfig = ''
    #  greeter-hide-users=false
    #'';
    desktopManager.xterm.enable = false;
  
    # Enable touchpad support.
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
      middleEmulation = false;
      tapping = true;

      # lower right corner of trackpad not treated as right click
      clickMethod = "clickfinger";
    };
  
    # Enable the KDE Desktop Environment.
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;
  };


  location.latitude = 51.0;
  location.longitude = 7.0;
  services.redshift = {
    enable = true;
    temperature.day = 5500;
    temperature.night = 3700;
  };

  services.batteryNotifier = {
    enable = true;
    notifyCapacity = 10;
    suspendCapacity = 5;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michael = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "plugdev" "adbusers" # Android programming
      "audio" "video" "networkmanager"
    ];
  };
  users.users.private = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "plugdev" "audio" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

