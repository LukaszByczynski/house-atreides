{ config, lib, pkgs, stdenv, ... }:

let
  username = "lbyczynski";
  homeDirectory = "/Users/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;

    sessionVariables = {
        DOCKER_HOST="unix://$HOME/.colima/docker.sock";
    };

  };

  imports = builtins.concatMap import [
    ./common
    ./programs
    ./programs-mbwork
  ];
}
