{ pkgs, pkgs-unstable, lib, ... }: {

  # a shell extension that manages your environment
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

}
