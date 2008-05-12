set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

" mappings
map <silent> <unique> b :BufExplorer<CR>
map <silent> <unique> + <C-w>+
map <silent> <unique> - <C-w>-

set number
set smartindent
set nobackup
set incsearch
set wrapscan
set smartcase ignorecase
set showcmd
set scrolloff=5

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

"colorscheme vibrantink

runtime! macros/matchit.vim
