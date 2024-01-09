let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      wrk2      # perf test
      nix-du    # track disk usage by nix roots
      dive      # A tool for exploring a docker image
      gitui     # GitUI provides you with the comfort of a git GUI but right in your terminal
    ];
  };
in [
  more
]
