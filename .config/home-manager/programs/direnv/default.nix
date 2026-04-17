{ pkgs, pkgs-unstable, lib, ... }: {

  # a shell extension that manages your environment
  programs.direnv = {
    enable = true;
    package = pkgs-unstable.direnv;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

}
