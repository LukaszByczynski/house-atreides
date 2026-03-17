let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.btop    # better top
      google-cloud-sdk      # gcloud sdk
      pkgs-unstable.devenv           # development env tool
    ];
  };
in [
  more
]
