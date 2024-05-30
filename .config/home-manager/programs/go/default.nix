{ config, pkgs, pkgs-unstable, lib, ... }:

let
in
{
  programs.go = {
    package = pkgs-unstable.go;

    enable = true;
    goPath = ".go";
  };
}
