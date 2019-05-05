" Terminal:
"---------------------------------------------------------------------------


"---------------------------------------------------------------------------
" Auto:
"---------------------------------------------------------------------------

augroup startup
  autocmd!

  " turn numbers on for normal buffers; turn them off for terminal buffers
  " autocmd TermOpen,BufWinEnter * call lib#SetNumberDisplay()

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

" function! lib#SetNumberDisplay()
" 	let l:buffername = @%
" 	
" 	if l:buffername =~ 'term://*'
" 		setlocal nonumber
" 		setlocal norelativenumber
" 		" setlocal scrolloff=0
" 	else
" 		setlocal number
" 		setlocal relativenumber
" 		" setlocal scrolloff=10
" 	endif
" endfunction
"

"---------------------------------------------------------------------------
" Functions:
"---------------------------------------------------------------------------

command! -nargs=0 TermVerticalSplit vsplit|term
command! -nargs=0 TermHorizontalSplit split|term


"---------------------------------------------------------------------------
" Mapping:
"---------------------------------------------------------------------------

  nnoremap <leader>tl :TermVerticalSplit<CR>
  nnoremap <leader>tj :TermHorizontalSplit<CR>

  " Window Navigation
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
