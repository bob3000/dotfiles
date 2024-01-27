# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/08b65709-13ea-4008-a062-895e5cbc32c9";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  networking.hostName = "repeater300"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  virtualisation = {
    docker.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bob = {
    isNormalUser = true;
    home = "/home/bob";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "disk"
      "docker"
      "storage"
      "video"
    ];
    packages = with pkgs; [
    ];
  };

  home-manager.users.bob = { pkgs, ... }: {
    programs.bash.enable = true;
  
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.variables = {
    EDITOR = "vim";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_STATE_HOME  = "$HOME/.local/state";
    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    asciinema
    bat
    bc
    bind
    binutils
    brave
    cachix
    chars
    clinfo
    cmake
    codespell
    coreutils-full
    davfs2
    dconf
    deja-dup
    delta
    diffpdf
    dmidecode
    dos2unix
    exfat
    extundelete
    eza
    fd
    ffmpeg-full
    file
    findutils
    fish
    fnm
    fortune
    fzf
    gcc
    gdb
    gettext
    git
    glxinfo
    gnomeExtensions.appindicator
    gnome.gnome-tweaks
    gnumake
    gnupg
    go
    gphoto2
    graphviz
    groff
    hddtemp
    home-manager
    htop
    iftop
    imagemagick
    iotop
    jq
    jq
    keepassxc
    killall
    kitty
    lazygit
    libunistring
    lsof
    lua
    luajit
    mullvad-vpn
    neovim
    netcat
    nextcloud-client
    nmap
    nodejs
    parallel
    parted
    patch
    pkgs.appimage-run
    powertop
    pyenv
    python3
    ripgrep
    rustup
    signal-desktop
    starship
    tcpdump
    telegram-desktop
    thunderbird
    tmux
    traceroute
    tree
    unrar
    unzip
    unzip
    vim
    virt-manager
    vorta
    wezterm
    wget
    wget
    whois
    wl-clipboard
    zip
    (
      hunspellWithDicts [
        hunspellDicts.de-de
        hunspellDicts.en-gb-large
      ]
    )
  ];

  fonts.packages = with pkgs; [
    emojione
    fira-code-nerdfont
    font-awesome
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-color-emoji
    twemoji-color-font
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

