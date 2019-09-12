#!/bin/sh
./coursier bootstrap ch.epfl.scala:scalafix-cli_2.12.8:0.9.6 -f --main scalafix.cli.Cli -o /usr/local/bin/scalafix