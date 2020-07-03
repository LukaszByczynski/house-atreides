#!/bin/sh
METALS_VERSION=0.9.1
rm /usr/local/bin/metals-emacs
rm /usr/local/bin/metals-sublime
coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=sublime \
  org.scalameta:metals_2.12:$METALS_VERSION \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-sublime -f
coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=emacs \
  org.scalameta:metals_2.12:$METALS_VERSION \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-emacs -f