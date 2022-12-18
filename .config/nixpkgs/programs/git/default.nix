{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
      pager  = "delta";
      excludesfile = "~/.gitignore_global";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool          = "vim_mergetool";
    };
    delta = {
      navigate = true;  # use n and N to move between diff sections
      side-by-side = true;
    };
    color = {
      ui = true;
    };
    mergetool."vim_mergetool" = {
      #cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
      # this command requires the vim-mergetool plugin
      cmd    = "nvim -f -c \"MergetoolStart\" \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"";
      prompt = false;
    };
    pull.rebase = false;
    push.autoSetupRemote = true;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "ssh://git@github.com".pushInsteadOf = "gh:";
      "https://gitlab.com/".insteadOf = "gl:";
      "ssh://git@gitlab.com".pushInsteadOf = "gl:";
    };
    include = {
      path = "~/.gitconfig.local";
    };
  };

  rg = "${pkgs.ripgrep}/bin/rg";
in
{
  home.packages = with pkgs.gitAndTools; [
    delta         # a syntax-highlighting pager for git
    hub           # github command-line client
    tig           # diff and commit view
  ];

  programs.git ={
    enable = true;

    extraConfig = gitConfig;
    userName = "Lukasz Byczynski";

    ignores = [
      "*.bloop"
      "*.bsp"
      "*.metals"
      "*.metals.sbt"
      "*metals.sbt"
      "*.direnv"
      "*.envrc"        # there is lorri, nix-direnv & simple direnv; let people decide
      "*.jvmopts"      # should be local to every project
    ];

    aliases = {
      amend = "commit --amend -m";
      fixup = "!f(){ git reset --soft HEAD~\${1} && git commit --amend -C HEAD; };f";
      loc   = "!f(){ git ls-files | ${rg} \"\\.\${1}\" | xargs wc -l; };f"; # lines of code
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      prune-branches = "!git remote prune origin && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -d";
    };
  };
}
