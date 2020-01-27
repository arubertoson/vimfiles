
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
"---------------------------------------------------------------------------
" Global AutoCmd:
"---------------------------------------------------------------------------

  augroup vimrc | execute 'autocmd!' | augroup END
  command! -nargs=* Gautocmd autocmd vimrc <args>
  command! -nargs=* Gautocmdft autocmd vimrc FileType <args>
  
  " Work around neovim 0.4.0+ bug
  " https://github.com/neovim/neovim/issues/9881
  " https://github.com/neoclide/coc.nvim/issues/668
  augroup secure_modeline_conflict_workaround
    autocmd!
    autocmd FileType help setlocal nomodeline
  augroup END

"---------------------------------------------------------------------------
" Global Events:
"---------------------------------------------------------------------------

  " Check if there are other open instances of file in buffer
  Gautocmd WinEnter * checktime

  " Use relative numbers only in buffer with focus
  Gautocmd WinLeave *? let [&l:number, &l:relativenumber] =
    \ &l:number ? [1, 0] : [&l:number, &l:relativenumber]
  Gautocmd WinEnter *? let [&l:number, &l:relativenumber] =
    \ &l:number ? [1, 1] : [&l:number, &l:relativenumber] 

  " Show listchars in insert mode 
  Gautocmd InsertEnter *? setlocal list
  Gautocmd InsertLeave *? setlocal nolist

  " Format options
  Gautocmdft *? setlocal formatoptions=cnmMj

  " Fix window position of help
  Gautocmd FileType help if &l:buftype ==# 'help' | wincmd K | endif

  " Always open read-only when a swap file is found
  Gautocmd SwapExists * let v:swapchoice = 'o'

  " Create directory if hierarchy doesn't exist
  Gautocmd BufWritePre,FileWritePre *?
    \ call vimrc#make_dir('<afile>:h', v:cmdbang)


augroup UserTermAug
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
