" Terminal:
"---------------------------------------------------------------------------

" Neoterm:
"---------------------------------------------------------------------------

  let g:neoterm_default_mod = 'botright'
  let g:neoterm_automap_keys = '<leader>tm'
  let g:neoterm_use_relative_path = 1
  let g:neoterm_autoscroll = 1

  let g:neoterm_autojump = 1
  let g:neoterm_autoinsert = 0

  let g:neoterm_direct_open_repl = 0
  let g:neoterm_always_open_to_exec = 0


"---------------------------------------------------------------------------
" Auto:
"---------------------------------------------------------------------------

augroup startup
  autocmd!

  " when in a neovim terminal, add a buffer to the existing vim session
	" instead of nesting (credit justinmk)
	autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
		\ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
		\ |let g:f=fnameescape(expand('%:p'))
		\ |noau bwipe
		\ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
		\ |qa
    \ |endif
  
  " enter insert mode whenever we're in a terminal
  autocmd TermOpen,BufWinEnter,BufEnter term://* startinsert
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber
augroup END


"---------------------------------------------------------------------------
" Functions:
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" Mapping:
"---------------------------------------------------------------------------

  " Window Navigation
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " Toggle
  nnoremap <silent> <leader>tt :<c-u>Ttoggle<cr>
  tnoremap <silent> <leader>tt <C-\><C-n><C-w>h:<c-u>Ttoggle<cr>

  " nnoremap <leader>tl :TermVerticalSplit<CR>
  " nnoremap <leader>tj :TermHorizontalSplit<CR>


  " xmap <leader>ts <plug>(neoterm-repl-send)
  " nmap <leader>ts <plug>(neoterm-repl-send)
  " nmap <leader>tsl <plug>(neoterm-repl-send-line)

  " nnoremap <silent> <leader>tR :<c-u>exec printf("%sTexec !! \<lt>cr>", v:count)<cr>
  " nnoremap <silent> <leader>tL :<c-u>exec printf('%sTclear!', v:count)<cr>

  " nnoremap <silent> <leader>tv :<c-u>exec printf('%sTtoggle', v:count)<cr>
  " nnoremap <silent> <leader>tl :<c-u>exec printf('botright vertical %s Ttoggle', v:count)<cr>
  nnoremap <silent> <leader>te :<c-u>exec printf('%sT exit', v:count)<cr>
  nnoremap <silent> <leader>tl :<c-u>exec printf('%sTclear', v:count)<cr>
  nnoremap <silent> <leader>tk :<c-u>exec printf('%sTkill', v:count)<cr>


  " cabbrev tt Ttoggle
  " cabbrev htt botright Ttoggle
  " cabbrev vtt botright vertical Ttoggle
  " cabbrev vt botright vertical T
