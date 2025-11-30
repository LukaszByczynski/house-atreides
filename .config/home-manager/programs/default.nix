let
  more = { pkgs, pkgs-unstable, lib, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.mc              # terminal file commander
      pkgs-unstable.btop            # better top
      pkgs-unstable.devenv          # development env tool
      pkgs-unstable.nil             # language server for NIX

      nix-tree        # look into nix-tree
      tldr            # better manual pages
      p7zip           # packer
      duf             # pretty disk usage
      gdu             # disk usage analyzer
      peco            # interactive filtering
      hyperfine       # benchmark tool
      mtr             # ping + traceroute
      cachix          # cache nix artifacts
      stress          # cpu stress tool
      fx              # json viewer
      rename          # rename tool
      ydiff
    ];

    programs = {

      #asciinema.enable = true;

      # recursive grep
      ripgrep.enable = true;

      # better find
      fd.enable = true;

      # cat replacement
      bat.enable = true;

      # an interactive tree view,
      broot = {
        enable = true;
        enableZshIntegration = true;
      };

      jq.enable = true;

      # modern ls
      eza = {
        enable = true;
        enableBashIntegration = true;
      };

      # jumping over dirs with history
      autojump = {
        enable = true;
        enableZshIntegration = true;
      };

      # history navigator
      hstr.enable = true;

      # less
      less.enable = true;

      # fuzzy search
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

    };
  };
in [
  ./direnv
  ./docker
  ./git
  ./go
  ./helix
  ./lazygit
  ./neovim
  ./ssh
  ./starship
  ./zsh
  more
]
