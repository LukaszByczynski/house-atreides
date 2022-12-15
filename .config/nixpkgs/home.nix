{ config, lib, pkgs, stdenv, ... }:

let
  username = "lukaszb";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    mc        # terminal file commander
    hstr      # history navigator
    nix-tree  # look into nix-tree
  ];
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
   ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";

    packages = defaultPkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";
}
