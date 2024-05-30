{ config, pkgs, pkgs-unstable, lib, ... }:

let
in
{
  programs.helix = {
    package = pkgs-unstable.helix;

    enable = true;
    defaultEditor = true;
  };
}
