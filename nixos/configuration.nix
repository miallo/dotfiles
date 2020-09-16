# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Scripts for changing the brightness of the keyboard backlight
      ./keyboard_backlight_scripts.nix
      # Custom scripts (i.e. Bevuta Standup)
      ./custom_scripts.nix
      # ZSH-init
      #./zsh_config.nix
      ./suspend_on_low_battery.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    #UI Stuff, backlight control
    xorg.xev #actkdb #xorg.xbacklight
    xorg.xkill xorg.xorgserver xorg.xf86inputevdev xorg.xf86inputsynaptics xorg.xf86inputlibinput
    lxappearance arandr
    brightnessctl
    dmidecode
    #xorg.xf86video*******************************
    #Notifications
    libnotify notify-osd #dunst 
    #Screensaver
    xautolock
    #Editors
    vim emacs
    #Disk usage
    ncdu gparted
    #zip
    zip unzip
    #Basic shell stuff
    curl zsh oh-my-zsh htop man_db tmux screen tree wget which xclip psmisc fd
    #Networking
    nmap nmap_graphical wirelesstools
 
    #FileExplorer
    pcmanfm #nautilus
    #Browser
    firefox chromium
    #Mail
    thunderbird
    #Messenger
    signal-desktop mattermost-desktop
    #Document viewers
    evince gnome3.eog
    #Image editing
    gimp inkscape imagemagick
    #Videos
    vlc ffmpeg
    #Sound
    pavucontrol
    #Documents
    libreoffice
    #LaTeX
    #(texlive.combine { inherit (texlive) scheme-medium changepage makecell subfigure graphbox adjustbox collectbox braket bbm fonts-extra; })
    texlive.combined.scheme-full
    #OCR
    tesseract

    ###Programming
    gitAndTools.gitFull
    #JVM
    openjdk11 scala leiningen maven
    android-studio
    #JS
    nodejs nodePackages.node2nix #nodePackages.expo-cli nodePackages.react-native-cli
    #Python
    python3
    #python3Packages.pip python3Packages.notebook #python3Packages.pygments python3Packages.matplotlib python3Packages.numpy python3Packages.scipy
  ];
  


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  #Control Backlight
  programs.light.enable = true;

  # List services that you want to enable:
  # USB Automounting
  services.gvfs.enable = true;  

  #Fingerprint Reader
  #services.fprintd.enable = true;
  #security.pam.services = {
  #  login.fprintAuth = true;
  #  xscreensaver.fprintAuth = true;
  #};

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth = {
    enable = true;
    config.General.ControllerMode = "bredr"; #"dual";
  };

  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    autorun = true;
    #desktopManager = {
    #  plasma5.enable = true;
    #  xterm.enable = false;
    #};
    layout = "de";
    #videoDrivers = [ "amdgpu" "radeon" ]; # "modesetting" ]; #amdgpu-pro
    #desktopManager = {
    #  xterm.enable = true;
    #};
    #displayManager = {
    #  startx.enable = true;
    #  #defaultSession = "none+i3";
    #};
    #desktopManager.lightdm.enable = true;
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
    displayManager.lightdm.enable = true;
    #displayManager.lightdm.autoLogin = {
    #  enable = true;
    #  user = "michael";
    #};
    desktopManager.xterm.enable = false;
    #displayManager.defaultSession = "none+i3";
    xkbOptions = "eurosign:e";
  
    # Enable touchpad support.
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
      middleEmulation = false;
      tapping = false;
    };
  
    # Enable the KDE Desktop Environment.
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;
  };

  services.mattermost = {
    enable = true;
    siteUrl = "https://team.bevuta.com";
  };
    

  location.latitude = 51.0;
  location.longitude = 7.0;
  services.redshift = {
    enable = false;
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
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
  users.users.private = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

