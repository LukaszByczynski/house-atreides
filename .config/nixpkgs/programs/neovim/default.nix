{ config, lib, pkgs, ... }:

let
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      :set number
      :set relativenumber
      :set autoindent
      :set smarttab
      :set tabstop=2
      :set shiftwidth=2
      :set mouse=a

      " Find files using Telescope command-line sugar.
      nnoremap <leader>fa <cmd>Telescope find_files<cr>
      nnoremap <leader>ff <cmd>Telescope git_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>

      lua << EOF
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      EOF
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      vim-commentary
      vim-airline
      plenary-nvim
      telescope-nvim
      which-key-nvim
      multiple-cursors
      vim-mergetool
      vim-repeat
      vim-surround
    ];
 };
}
