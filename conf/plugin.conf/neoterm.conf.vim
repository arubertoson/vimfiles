
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
" Terminal
"---------------------------------------------------------------------------
" Neoterm:
"---------------------------------------------------------------------------

  " let g:neoterm_default_mod = 'rightbelow'
  let g:neoterm_automap_keys = '<leader>tm'
  let g:neoterm_use_relative_path = 1
  let g:neoterm_autoscroll = 1

  let g:neoterm_autojump = 1
  let g:neoterm_autoinsert = 0

  let g:neoterm_direct_open_repl = 0
  let g:neoterm_always_open_to_exec = 0

"---------------------------------------------------------------------------
"Functions:

  function! SplitCommand(...)
    let l:command = a:0 ? a:1 : ''
    if winwidth('%') >= 120 " Minimum width
      let l:width = winwidth('%')/2

      execute 'vertical botright ' . l:command
      execute 'vertical resize ' . l:width
    else
      execute 'rightbelow ' . l:command
    endif
  endfunction

"---------------------------------------------------------------------------
"Mapping:

  command! WinSplit call SplitCommand('Ttoggle')

  " Window Navigation
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " Toggle
  nnoremap <silent> <leader>tt :<c-u>WinSplit<cr>
  tnoremap <silent> <leader>tt <C-\><C-n><C-w>h:<c-u>Ttoggle<cr>

  nnoremap <silent> <leader>tl :<c-u>exec printf('%sTclear', v:count)<cr>
