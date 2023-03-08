{ config, pkgs, pkgs-unstable, lib, ... }:

{
  programs.go = {
    package = pkgs-unstable.go;

    enable = true;
    goPath = ".go";
  };
}
