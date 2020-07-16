#!/bin/sh
coursier bootstrap ch.epfl.scala:scalafix-cli_2.12.11:0.9.18 -f --main scalafix.cli.Cli -o /usr/local/bin/scalafix