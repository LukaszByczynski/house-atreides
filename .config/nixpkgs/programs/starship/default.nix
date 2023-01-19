{ config, pkgs, lib, ... }:

let
  defaultSettings = {

    # Increase Starship command scan & duration time-outs
    scan_timeout = 80;
    command_timeout = 1000;

    format = lib.concatStrings [
        "[](#9A348E)"
        "$os"
        "[](bg:#DA627D fg:#9A348E)"
        "$directory"
        "[](fg:#DA627D bg:#FCA17D)"
        "$git_branch"
        "$git_status"
        "[](fg:#FCA17D)"
        " $c"
      ];

      right_format = lib.concatStrings [
        "[](fg:#86BBD8)"
        "$golang"
        "$java"
        "$nodejs"
        "$rust"
        "$scala"
        # "$docker_context"
        "[](bg:#86BBD8 fg:#33658A)"
        "$time"
        "$cmd_duration"
        "[](fg:#33658A)"
      ];

      # Disable the blank line at the start of the prompt
      # add_newline = false

      # You can also replace your username with a neat symbol like   or disable this
      # and use the os module below
      username = {
        show_always = true;
        style_user = "bg:#9A348E";
        style_root = "bg:#9A348E";
        format = "[$user ]($style)";
        disabled = false;
      };

      # An alternative to the username module which displays a symbol that
      # represents the current operating system
      os = {
        style = "bg:#9A348E";
        disabled = false; # Disabled by default
      };

      directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "../";
      };

      c = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#FCA17D";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#FCA17D";
        format = "[$all_status$ahead_behind ]($style)";
      };

      golang = {
        style = "bg:#86BBD8";
        format = "[ go $version ]($style)";
      };

      haskell = {
        style = "bg:#86BBD8";
        format = "[ haskell $version ]($style)";
      };

      java = {
        style = "bg:#86BBD8";
        version_format = "$minor";
        format = "[ jdk$version ]($style)";
      };

      nodejs = {
        style = "bg:#86BBD8";
        format = "[ node $version ]($style)";
      };

      rust = {
        style = "bg:#86BBD8";
        format = "[ rust ($version) ]($style)";
      };

      scala = {
        style = "bg:#86BBD8";
        format = "[ | scala ($version) ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#33658A";
        format = "[🕙 $time ]($style)";
      };

      cmd_duration = {
        style = "bg:#33658A";
        format = "[|> $duration ]($style)";
        show_milliseconds = true;
      };
  };

in {

   programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = defaultSettings;
    };
}
