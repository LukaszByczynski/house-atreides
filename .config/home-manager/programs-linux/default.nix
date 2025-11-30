let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      wrk2        # perf test
      nix-du      # track disk usage by nix roots
      lnav        # better logs navigator

      pkgs-unstable.claude-code
    ];

    programs.bash = {
      enable = true;

      #profileExtra = ''
      #[[ -f ~/.bashrc ]] && . ~/.bashrc
      #'';

      bashrcExtra = ''
      # If not running interactively, don't do anything (leave this at the top >
      [[ $- != *i* ]] && return

      # All the default Omarchy aliases and functions
      # (don't mess with these directly, just overwrite them here!)
      source ~/.local/share/omarchy/default/bash/rc

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
