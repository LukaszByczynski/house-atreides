let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.mc        # terminal file commander
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
      lnav            # better logs navigator
      mtr             # ping + traceroute
      btop            # better top
      cachix          # cache nix artifacts
      nix-index       # for searching files in the packages
      kubectl         # k8s cli tool
      stress          # cpu stress tool
      ctop            # monitoring docker containers
      gitui           # GitUI provides you with the comfort of a git GUI but right in your terminal
      dive            # A tool for exploring a docker image
      docker-client   # docker cli
      fx              # json viewer

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
        enableAliases = true;
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
  ./starship
  ./git
  ./go
  ./neovim
  ./zsh
  more
]