{ config, lib, pkgs, pkgs-unstable,  stdenv, ... }:

let
  username = "lukaszb";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  # todo: this driver should be taken from unstabkle
  customNvidiaX11 = pkgs-unstable.linuxPackages.nvidia_x11_production.override {
    libsOnly = true;
    disable32Bit = false;
  };

in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";

    sessionVariables = {
      # DISPLAY = ":0";
      EDITOR = "nvim";
      # force use nvidia vaapi driver for video decoding
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      #LD_LIBRARY_PATH="${customNvidiaX11}/lib:$LD_LIBRARY_PATH";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";

  imports = builtins.concatMap import [
    ./programs
  ];
}
