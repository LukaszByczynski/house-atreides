{ config, pkgs, lib, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
      pager  = "delta";
      excludesfile = "~/.gitignore_global";
    };
    init = {
      defaultBranch = "main";
    };
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
    diff = {
      tool = "vimdiff";
      algorithm = "histogram";    # Clearer diffs on moved/edited lines
      colorMoved = "plain";       # Highlight moved blocks in diffs
      mnemonicPrefix = true;    # More intuitive refs in diff output
    };
    column = {
      ui = "auto"; # output in column when possible
    };
    commit = {
      verbose = true; # Include diff comment in commit message template
    };
    mergetool = {
      "vim_mergetool" = {
        #cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
        # this command requires the vim-mergetool plugin
        cmd    = "nvim -f -c \"MergetoolStart\" \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"";
        prompt = false;
      };
    };
    branch = {
      sort = "-committerdate";    # Sort branches by most recent commit first
    };
    tag = {
      sort = "-version:refname";  # Sort version numbers as you would expect
    };
    rerere = {
      enabled = true;           # Record and reuse conflict resolutions
	    autoupdate = true;        # Apply stored conflict resolutions automatically 
    };
    pull = {
      rebase = false;
    };
    push = {
      autoSetupRemote = true;
    };
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
  home.packages = with pkgs;[
    delta         # a syntax-highlighting pager for git
    hub           # github command-line client
    tig           # diff and commit view
  ];

  programs.git ={
    enable = true;

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

    settings = lib.recursiveUpdate gitConfig {
      user.name = "Lukasz Byczynski";
      alias = {
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
        #prune-branches = "!git remote prune origin && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D";
        prune-branches = "!LANG=en_EN git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D";
      };
    };
  };
}
