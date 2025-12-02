let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.claude-code
      pkgs-unstable.btop            # better top
    ];
  };
in [
  more
]
