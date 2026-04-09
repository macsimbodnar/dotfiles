" Minimal and practical ~/.vimrc

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Disable old vi compatibility
set nocompatible

" Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" UI
set number
set ruler
set showmatch
set cursorline

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Editing
set backspace=indent,eol,start
set textwidth=120

" Mouse and clipboard
set mouse=a
set clipboard=unnamed

" Better splits
set splitbelow
set splitright

" Syntax and filetype support
syntax on
filetype plugin indent on

" Better terminal colors when supported
if has('termguicolors')
    set termguicolors
endif
