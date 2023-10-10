let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      wrk2      # perf test
    ];
  };
in [
  more
]
