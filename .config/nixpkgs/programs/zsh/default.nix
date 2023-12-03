{ config, pkgs, lib, ... }:

let
  initPrelude = ''
    # Make sure ZDOTDIR is ~/.zsh.d
    # ZDOTDIR=~/.zsh.d

    # Nix
    [[ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]] && . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    [[ -e ~/.nix-profile/etc/profile.d/nix.sh ]] && . ~/.nix-profile/etc/profile.d/nix.sh
    # End Nix
  '';

  initHistory = ''
      setopt histignorespace
      export HISTFILE
      export HSTR_CONFIG=hicolor           # get more colors
      bindkey -s "\C-r" "hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
  '';

  aliases = {
    ".." = "cd ..";
    "ff" = "fzf";
    "vs" = "code .";
    "sm" = "smerge .";
    "m_import" = "rm -rf .bloop .metals; sbt bloopInstall";
    "m_rmmetals" = "rm -rf .bloop .metals";
    "m_rmtarget" = "find . -type d -name target -exec rm -rf {} \;";
    "m_rmnode" = "rm -rf .nuxt node_modules yarn.lock";
    "cat" = "bat";
    "hh" = "hstr";
    "napi" = "/var/empty/local/bin/napi.sh download";
    "jsmb" = "cd $XDG_RUNTIME_DIR/gvfs";
  };

in {
  programs.zsh = {
    enable = true;

    #interactiveShellInit = ''
    #  eval (direnv hook fish)
    #  any-nix-shell fish --info-right | source
    #'';

    prezto = {
      enable = true;
      extraFunctions = ["zmv"];
    };

    # this sources nix in the newly created .zshrc
    initExtra = initPrelude + initHistory;

    history = {
      extended = true;
      path = "${config.home.homeDirectory}/.zsh.d/.zsh_history";
    };

    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = aliases;
  };
}
