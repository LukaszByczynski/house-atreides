let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      wrk2      # perf test
      nix-du    # track disk usage by nix roots
    ];
  };
in [
  more
]
