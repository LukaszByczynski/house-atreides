let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      pkgs-unstable.btop    # better top
      google-cloud-sdk      # gcloud sdk
      pkgs.devenv           # development env tool
    ];
  };
in [
  more
]
