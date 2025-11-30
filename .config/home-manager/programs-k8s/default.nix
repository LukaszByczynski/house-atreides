let
  more = { pkgs, pkgs-unstable, lib, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.kubectl         # k8s cli tool
    ];

    programs.k9s.enable = true;

  };
in [
  more
]
