
" Vim buffer config
"
" This module contains settings when working with vim filetype


" Only do this when not done yet for this buffer
if exists("b:ft_vim_buffer")
  finish
endif
let b:ft_vim_buffer = 1


setlocal iskeyword+=:,#
setlocal foldmethod=indent
setlocal keywordprg=:help

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=80
setlocal expandtab
setlocal smarttab
setlocal nosmartindent
setlocal foldmethod=indent

" noremap <silent><buffer><unique> <F9> :%y"<CR>:@"<CR>
noremap <silent><buffer><unique> <F9> :w<CR>:so %<CR>
