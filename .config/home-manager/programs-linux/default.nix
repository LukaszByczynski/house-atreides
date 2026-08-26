let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      wrk2        # perf test
      nix-du      # track disk usage by nix roots
      lnav        # better logs navigator

      pkgs-unstable.devenv          # development env tool
      pkgs-unstable.claude-code
      pkgs-unstable.rtk
    ];

    programs.bash = {
      enable = true;

      #profileExtra = ''
      #[[ -f ~/.bashrc ]] && . ~/.bashrc
      #'';

      bashrcExtra = ''
      # Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
      [[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

      # If not running interactively, don't do anything else (leave this above the rc source)
      [[ $- != *i* ]] && return

      # All the default Omarchy aliases and functions
      # (don't mess with these directly, just overwrite them here!)
      source "$OMARCHY_PATH/default/bash/rc"

      # Add your own exports, aliases, and functions here.
      #
      # Make an alias for invoking commands you use constantly
      # alias p='python'
      '';
    };
  };
in [
  ./alacritty
  more
]
