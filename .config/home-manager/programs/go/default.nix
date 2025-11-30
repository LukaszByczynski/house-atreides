{ config, pkgs, pkgs-unstable, lib, ... }:

let
in
{
  home.packages = with pkgs; [
    pkgs-unstable.gopls           # go language server
    pkgs-unstable.go-tools        # go-tools (static analyzer, etc)
    pkgs-unstable.delve           # go debugger
  ];

  programs.go = {
    package = pkgs-unstable.go;

    enable = true;
    env.GOPATH = ".go";
  };
}
