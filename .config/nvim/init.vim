:set number
:set relativenumber
:set autoindent
:set smarttab
:set tabstop=2
:set shiftwidth=2
:set mouse=a

call plug#begin()

" window splitter
Plug 'https://github.com/beauwilliams/focus.nvim'

" tree bar
Plug 'nvim-treesitter/nvim-treesitter'

" commentary plugin
Plug 'https://github.com/tpope/vim-commentary'

" status bar
Plug 'https://github.com/vim-airline/vim-airline'

" file/code navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" keys sugestion
Plug 'folke/which-key.nvim'

call plug#end()

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
