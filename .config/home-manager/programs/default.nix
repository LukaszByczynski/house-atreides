let
  more = { pkgs, pkgs-unstable, lib, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.mc              # terminal file commander
      pkgs-unstable.btop            # better top
      pkgs-unstable.kubectl         # k8s cli tool
      pkgs-unstable.ctop            # monitoring docker containers
      pkgs-unstable.dive            # A tool for exploring a docker image
      pkgs-unstable.docker-client   # docker cli
      pkgs-unstable.docker-compose  # docker compose
      pkgs-unstable.colima          # container engine for docker
      pkgs-unstable.devenv          # development env tool
      pkgs-unstable.nil             # language server for NIX

      pkgs-unstable.gopls           # go language server
      pkgs-unstable.go-tools        # go-tools (static analyzer, etc)
      pkgs-unstable.delve           # go debugger

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

      lazygit = {
        enable = true;
        settings = {
          gui.sidePanelWidth =  0.2; # gives you more space to show things side-by-side
          git.pagers = [
            {pager = "ydiff -p cat -s --wrap --width={{columnWidth}}";}
          ];
        };
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
        enableDefaultConfig = false;
        matchBlocks."*" = {
          forwardAgent = false;
          serverAliveInterval = 60;
          serverAliveCountMax = 3;
          compression = false;
          addKeysToAgent = "no";
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };
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

      # history navigator
      hstr.enable = true;

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
