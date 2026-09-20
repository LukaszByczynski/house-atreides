let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
    ];
  };
in [
  more
]
