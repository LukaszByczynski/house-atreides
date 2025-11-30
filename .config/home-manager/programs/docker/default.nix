{ pkgs, pkgs-unstable, lib, ... }: {

  home.packages = with pkgs; [
    pkgs-unstable.dive            # A tool for exploring a docker image
    pkgs-unstable.docker-client   # docker cli
    pkgs-unstable.docker-compose  # docker compose
    pkgs-unstable.colima          # container engine for docker
    pkgs-unstable.ctop            # monitoring docker containers
  ];

}
