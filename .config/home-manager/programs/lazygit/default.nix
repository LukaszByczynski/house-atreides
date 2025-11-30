{ pkgs, pkgs-unstable, lib, ... }: {

  programs.lazygit = {
    enable = true;
    settings = {
      gui.sidePanelWidth =  0.2; # gives you more space to show things side-by-side
      git.pagers = [
        {pager = "ydiff -p cat -s --wrap --width={{columnWidth}}";}
      ];
    };
  };

}
