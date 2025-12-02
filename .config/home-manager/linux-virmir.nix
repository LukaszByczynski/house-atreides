{ config, lib, pkgs, pkgs-unstable,  stdenv, ... }:

let
  username = "lukaszb";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  # use host GPU libs
  targets.genericLinux.enable = true;
  
  # Home Maanager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;

    sessionVariables = {
      DOCKER_HOST="unix://$HOME/.config/colima/docker.sock";
    };
  };

  imports = builtins.concatMap import [
    ./common
    ./programs
    ./programs-linux
  ];
}
