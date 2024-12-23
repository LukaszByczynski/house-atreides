let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      wrk2      # perf test
      nix-du    # track disk usage by nix roots
      lnav      # better logs navigator
    ];
  };
in [
  more
]
