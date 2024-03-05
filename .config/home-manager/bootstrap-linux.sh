#!/bin/bash

set -e

# jump to workdir
cd ~/.config/nixpkgs/

# install nix standalone
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# jump to nix shell
. ~/.nix-profile/etc/profile.d/nix.sh

# build home env
nix build '.#homeConfigurations.szwagier.activationPackage'

# activate
./result/activate
