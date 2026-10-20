let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      google-cloud-sdk      # gcloud sdk
      pkgs-unstable.colima          # container engine for docker
    ];
  };
in [
  more
]
