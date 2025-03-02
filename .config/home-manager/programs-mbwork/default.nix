let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      google-cloud-sdk   # gcloud sdk
    ];
  };
in [
  more
]
