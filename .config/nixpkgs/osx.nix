{ config, lib, pkgs, pgks-unstable, stdenv, ... }:

let
  username = "lukasz";
  homeDirectory = "/Users/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;
  };

  imports = builtins.concatMap import [
    ./common
    ./programs
  ];
}
