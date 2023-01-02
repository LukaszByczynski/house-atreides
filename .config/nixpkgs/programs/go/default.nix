{ config, pkgs, lib, ... }:

{
  programs.go = {
    enable = true;
    goPath = ".go";
  };
}
