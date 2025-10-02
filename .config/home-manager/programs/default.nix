let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.mc              # terminal file commander
      pkgs-unstable.btop            # better top
      pkgs-unstable.kubectl         # k8s cli tool
      pkgs-unstable.ctop            # monitoring docker containers
      pkgs-unstable.gitui           # GitUI provides you with the comfort of a git GUI but right in your terminal
      pkgs-unstable.dive            # A tool for exploring a docker image
      pkgs-unstable.docker-client   # docker cli
      pkgs-unstable.docker-compose  # docker compose
      pkgs-unstable.colima          # container engine for docker

      hstr            # history navigator
      nix-tree        # look into nix-tree
      tldr            # better manual pages
      p7zip           # packer
      ripgrep         # recursive grep
      duf             # pretty disk usage
      gdu             # disk usage analyzer
      peco            # interactive filtering
      fd              # better find
      hyperfine       # benchmark tool
      asciinema       # console recorder
      mtr             # ping + traceroute
      cachix          # cache nix artifacts
      nix-index       # for searching files in the packages
      stress          # cpu stress tool
      fx              # json viewer
      rename          # rename tool

      devenv          # development env tool
      nil             # language server for NIX

      pkgs-unstable.gopls     # go language server
      pkgs-unstable.go-tools  # go-tools (static analyzer, etc)
      pkgs-unstable.delve     # go debugger
    ];

    programs = {

      # cat replacement
      bat.enable = true;

      # an interactive tree view,
      broot = {
        enable = true;
        enableZshIntegration = true;
      };

      # a shell extension that manages your environment
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      jq.enable = true;

      # ssh config
      ssh = {
        enable = true;
        serverAliveInterval = 60;
        includes = ["local_config"];
      };

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

      # less
      less.enable = true;

      #k9s
      k9s.enable = true;

      # fuzzy search
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

    };
  };
in [
  ./git
  ./go
  ./helix
  ./neovim
  ./starship
  ./zsh
  more
]
