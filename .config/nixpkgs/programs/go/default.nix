{ config, pkgs, lib, ... }:

{
  programs.go = {
    enable = true;
    goPath = "${config.home.homeDirectory}/.go";
  };
}
