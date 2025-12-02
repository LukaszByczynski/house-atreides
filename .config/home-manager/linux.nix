{ config, lib, pkgs, pkgs-unstable,  stdenv, ... }:

let
  username = "lukaszb";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
in
{

  # use host GPU libs
  targets.genericLinux.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;

    sessionVariables = {
      # force use nvidia vaapi driver for video decoding
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      GOPATH = "$HOME/.go";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      DOCKER_HOST="unix://$HOME/.config/colima/docker.sock";
    };
  };

  imports = builtins.concatMap import [
    ./common
    ./programs
    ./programs-linux
  ];
}
