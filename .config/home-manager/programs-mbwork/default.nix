let
  more = { pkgs, pkgs-unstable, ... }: {

    home.packages = with pkgs; [
      sqlite
      awscli2
      google-cloud-sql-proxy
      google-cloud-sdk      # gcloud sdk
      pkgs-unstable.colima  # container engine for docker
    ];
  };
in [
  ./go
  more
]
