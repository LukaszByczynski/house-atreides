#!/bin/sh
METALS_VERSION=0.10.6
rm /usr/local/bin/metals-emacs
rm /usr/local/bin/metals-sublime
cs bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=sublime \
  org.scalameta:metals_2.12:$METALS_VERSION \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-sublime -f
cs bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=emacs \
  org.scalameta:metals_2.12:$METALS_VERSION \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-emacs -f