syntax on
filetype on
set nocompatible
set number
set nowrap
set encoding=utf-8
set cursorline
set fileformat=unix

" Search config
set hlsearch
set ignorecase
set smartcase
set incsearch

set mouse=a
let mapleader=","

call plug#begin()
Plug 'ghifarit53/tokyonight-vim'
call plug#end()

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight