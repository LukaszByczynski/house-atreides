:set number
:set relativenumber
:set autoindent
:set smarttab
:set tabstop=2
:set shiftwidth=2
:set mouse=a

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

