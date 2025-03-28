let
  more = { pkgs, pkgs-unstable, ... }: {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home = {
      # The state version is required and should stay at the version you
      # originally installed.
      stateVersion = "23.11";

      sessionVariables = {
        # DISPLAY = ":0";
        EDITOR = "hx";
        NIX_PATH="nixpkgs=${pkgs-unstable.path}:nixpkgs_stable=${pkgs.path}";
        NIXPKGS_ALLOW_UNFREE=1;
        PATH="$PATH:$HOME/.local/bin:$GOPATH/bin";
      };
    };

    # restart services on change
    systemd.user.startServices = "sd-switch";

    # notifications about home-manager news
    news.display = "silent";
  };
in [
  more
]
