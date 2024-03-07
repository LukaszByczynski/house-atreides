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
        EDITOR = "nvim";
        NIX_PATH="nixpkgs=${pkgs-unstable.path}:nixpkgs_stable=${pkgs.path}";
        NIXPKGS_ALLOW_UNFREE=1;
        DOCKER_HOST="unix://$HOME/.colima/docker.sock";
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
