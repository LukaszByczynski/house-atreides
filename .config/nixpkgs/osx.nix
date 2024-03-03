{ config, lib, pkgs, pgks-unstable, stdenv, ... }:

let
  username = "lukasz";
  homeDirectory = "/Users/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;

    # The state version is required and should stay at the version you
    # originally installed.
    stateVersion = "23.11";


    sessionVariables = {
      # DISPLAY = ":0";
      EDITOR = "nvim";
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
