{ pkgs, pkgs-unstable, lib, ... }: {

  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "~/.config/alacritty/alacritty_local.toml"
        ];
      };
      env = {
        TERM = "xterm-256color";
      };
      font = {
        normal = { family = "Iosevka"; };
        bold = { family = "Iosevka"; };
        italic = { family = "Iosevka"; };
        size = 14;
      };
      window = {
        padding = {
          x = 14;
          y = 14;
        };
        decorations = "None";
      };
      keyboard = {
        bindings = [
          { key = "Insert"; mods = "Shift"; action = "Paste"; }
          { key = "Insert"; mods = "Control"; action = "Copy"; }
        ];
      };
      terminal.shell = {
        program = "/usr/bin/zsh";
      };
    };
  };

}
