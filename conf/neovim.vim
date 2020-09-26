
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
" Neovim Specific Settings:
"---------------------------------------------------------------------------

set termguicolors

set pumblend=20              " transparant for popupmenu
set wildoptions=pum

set packpath=

set autoread

set switchbuf+=vsplit               " Switch buffer behavior to vsplit

set completeopt+=noselect           " Do not select a match in the menu
set completeopt+=noinsert           " Do not insert any text

let $PATH .= ':' . g:vimpath . "/bin"

" Do not use providers
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0

" let g:loaded_python_provider = 0
" let g:loaded_python3_provider = 0

let g:python_host_prog = "/scratch/package/pyenv/versions/2.7.18/envs/nvim2/bin/python2.7"
let g:python3_host_prog = "/scratch/package/pyenv/versions/3.8.5/envs/nvim3/bin/python3.8"
let pyx=3

"  ShaDa/viminfo:
"   ' - Maximum number of previously edited files marks
"   < - Maximum number of lines saved for each register
"   @ - Maximum number of items in the input-line history to be
"   s - Maximum size of an item contents in KiB
"   h - Disable the effect of 'hlsearch' when loading the shada
set shada='300,<10,@50,s100,h
