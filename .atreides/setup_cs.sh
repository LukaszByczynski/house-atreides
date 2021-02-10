#!/bin/sh
curl -fLo cs https://git.io/coursier-cli-$(uname | tr LD ld) && chmod +x cs && ./cs