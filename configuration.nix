# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Panama";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_PA.UTF-8";
    LC_IDENTIFICATION = "es_PA.UTF-8";
    LC_MEASUREMENT = "es_PA.UTF-8";
    LC_MONETARY = "es_PA.UTF-8";
    LC_NAME = "es_PA.UTF-8";
    LC_NUMERIC = "es_PA.UTF-8";
    LC_PAPER = "es_PA.UTF-8";
    LC_TELEPHONE = "es_PA.UTF-8";
    LC_TIME = "es_PA.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us,es";
    xkbVariant = "";
    xkbOptions = "grp:win_space_toggle";
  };
  services.printing.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jz = {
    isNormalUser = true;
    description = "Joseph";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.zsh;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Programming
    gcc
    git
    neovim
    vim
    zsh
    # Utility
    gotop
    guake
    flameshot
    insomnia
    konsole
    obs-studio
    oh-my-zsh
    pcmanfm
    qalculate-qt
    solaar
    unzip
    wget
    # Productivity
    audacity
    inkscape
    kdenlive
    # VM
    bridge-utils
    dmidecode
    dnsmasq
    ebtables
    iptables
    qemu
    qemu_kvm
    libguestfs
    vde2
    virt-manager
    virt-viewer
    # System
    arandr
    autorandr
    i3
    lightdm
    picom
    rofi
    xarchiver
    # Browser
    firefox
    # Messaging
    ferdium
    # Office work
    gimp
    obsidian
    wpsoffice
    # Multimedia
    vlc
    spotify
  ];
  environment.shells = with pkgs;[ zsh ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.zsh.enable = true;
  programs.zsh = {
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "golang" ];
      theme = "agnoster";
    };
  };
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" ];})
  ];
  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "CascadiaCode" ];
	serif = [ "CascadiaCode" ];
	monospace = [ "CascadiaCode" ];
      };
    };
  };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
   services.xserver = {
	enable = true;
	autorun = true;
	displayManager.defaultSession = "none+i3";
	desktopManager.xterm.enable = false;
	windowManager.i3.enable = true;
   };
   # VM settings
   virtualisation.libvirtd.enable = true;
   programs.dconf.enable = true;
   

 
  services.picom.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
