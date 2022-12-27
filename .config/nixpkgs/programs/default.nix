let
  more = { pkgs, ... }: {

    home.packages = with pkgs; [
      mc        # terminal file commander
      hstr      # history navigator
      nix-tree  # look into nix-tree
      tldr      # better manual pages
      p7zip     # packer
      ripgrep   # recursive grep
      duf       # pretty disk usage
      gdu       # disk usage analyzer
      peco      # interactive filtering
      fd        # better find
      hyperfine # benchmark tool
      asciinema # console recorder
      lnav      # better logs navigator
      mtr       # ping + traceroute
      btop      # better top
      cachix
    ];

    programs = {

      # powerline
      # powerline-go = {
      #   enable = true;
      #   modules = ["cwd" "git"];
      #   modulesRight = ["exit" "direnv" "time"];
      #   settings = {
      #     numeric-exit-codes = "";
      #   };
      # };

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
      exa = {
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
