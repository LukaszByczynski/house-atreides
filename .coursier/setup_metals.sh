#!/bin/sh
rm /usr/local/bin/metals-sublime
./coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=sublime \
  org.scalameta:metals_2.12:0.7.6 \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-sublime -f
