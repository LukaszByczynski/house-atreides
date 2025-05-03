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

      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fc <cmd>Telescope git_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>

      lua << EOF
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "📦",
                    package_pending = "📦𐄡",
                    package_uninstalled = "𐄡",
                },
            }
        })

        local rt = require("rust-tools")
        rt.setup({
          server = {
            on_attach = function(_, bufnr)
              -- Hover actions
              vim.keymap.set("n", "<Tab>", rt.hover_actions.hover_actions, { buffer = bufnr })
              -- Code action groups
              vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            end,
          },
        })


        -- local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
        -- vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
        -- vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

        require("mason-lspconfig").setup()
      EOF
    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
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
      nvim-tree-lua
      nvim-cmp
      nvim-ale-diagnostic
      editorconfig-nvim
      indent-blankline-nvim
      lualine-nvim
      mason-nvim
      mason-lspconfig-nvim
      rust-tools-nvim
      VimCompletesMe
    ];
 };
}
