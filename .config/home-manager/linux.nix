{ config, lib, pkgs, pkgs-unstable,  stdenv, ... }:

let
  username = "lukaszb";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  customNvidiaX11 = pkgs-unstable.linuxPackages.nvidia_x11_production.override {
    libsOnly = true;
    disable32Bit = false;
  };

in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;

    sessionVariables = {
      # force use nvidia vaapi driver for video decoding
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      LD_LIBRARY_PATH="${customNvidiaX11}/lib:$LD_LIBRARY_PATH";
      GBM_BACKENDS_PATH="${customNvidiaX11}/lib/gbm";
      DOCKER_HOST="unix://$HOME/.config/colima/docker.sock";
    };
  };

  imports = builtins.concatMap import [
    ./common
    ./programs
    ./programs-linux
  ];
}
