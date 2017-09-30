"
"   vimrc
"   Repo URL: https://github.com/LER0ever/EverVim
"   Author: Marcus Albertsson
"   Licensed under
"       * MIT
"---------------------------------------------------------------------------


if has('reltime') && has('vim_starting')
  " Shell: vim --startuptime filename -q; vim filename
  " vim --cmd 'profile start profile.txt' --cmd 'profile file $HOME/.vimrc' 
  "  \ +q && vim profile.txt
  let s:startupTime = reltime()
  augroup VimEnter
    autocmd! VimEnter * let s:startupTime = reltime(s:startupTime)
      \ | redraw | echomsg reltimestr(s:startupTime)
  augroup END
endif


" Environemnt
"
" Set main configuration directory, and where cache is stored
"---------------------------------------------------------------------------

  let $VIMFILES = expand('$HOME/vimfiles')
  let $VIMHOME = expand((has('nvim') ? '$HOME/.nvim' : '$HOME/.vim'))
  let $MIVFILES = expand('$VIMFILES/miv/miv')
  let $CACHE = expand('$HOME/.cache/vim')

  let g:loaded_python_provider = 1
  let g:python2_host_prog = "c:/python/2713_x64/python"
  let g:python3_host_prog = "c:/python/362_x64/python"

  set runtimepath=$VIMFILES,$VIMRUNTIME

  set nomodeline modelines=0  " prevents security exploits
  set noexrc                  " avoid reading local (g)vimrc, exrc
  set packpath=
  " set noswapfile
  set regexpengine=2          " 0=auto 1=old 2=NFA

" Undo
  set undodir=$CACHE/undo
  set undofile undolevels=500 undoreload=1000
  " View
  set viewdir=$CACHE/view
  set viewoptions=cursor,slash,unix
  " Tmp
  set directory=$CACHE

  if has('nvim')
    set inccommand=split
    set clipboard+=unnamedplus
  endif

  " Initialize autogroup
  augroup MyVimrc | execute 'autocmd!' | augroup END


" Commands
"---------------------------------------------------------------------------
  command! -nargs=* MyAuto autocmd MyVimrc <args>
  command! -nargs=* MyAutoFT autocmd MyVimrc FileType <args>
  command! -nargs=1 Indent execute
    \ 'setlocal tabstop='.<q-args>
    \ 'softtabstop='.<q-args>
    \ 'shiftwidth='.<q-args>
  command! -nargs=0 -bar GoldenRatio exe 'vertical resize' &columns * 5 / 8
   " Shows the syntax stack under the cursor
  command! -bar SS echo 
    \ map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  command! -nargs=? SetColorScheme call vimrc#set_theme(<q-args>)

" Events
"---------------------------------------------------------------------------
  if exists('$MYVIMRC')
    autocmd MyVimrc BufWritePost $MYVIMRC | source $MYVIMRC | redraw
  endif
  MyAuto Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif
  " Check if there are other open instances of file in buffer
  MyAuto WinEnter * checktime
  " Use relative numbers only in buffer with focus
  MyAuto WinLeave *? let [&l:number, &l:relativenumber] =
    \ &l:number ? [1, 0] : [&l:number, &l:relativenumber]
  MyAuto WinEnter *? let [&l:number, &l:relativenumber] =
    \ &l:number ? [1, 1] : [&l:number, &l:relativenumber] 
  " Show listchars in insert mode 
  MyAuto InsertEnter *? setlocal list
  MyAuto InsertLeave *? setlocal nolist
  " Format options
  MyAutoFT *? setlocal formatoptions=cmMj
  " Fix window position of help
  MyAuto FileType help if &l:buftype ==# 'help' | wincmd K | endif
  " Always open read-only when a swap file is found
  MyAuto SwapExists * let v:swapchoice = 'o'

" Functions
"---------------------------------------------------------------------------
  function! IsWindows() abort
    return has('win64') || has('win32') || has('win32unix')
  endfunction

  function! IsMac() abort
    return !IsWindows()
          \ && (has('mac') || has('macunix') || has('gui_macvim')
          \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
  endfunction

" Vimrc
"---------------------------------------------------------------------------
  " MakeDir
  command! -nargs=1 -bang MakeDir call vimrc#make_dir(<f-args>, "<bang>")
  MyAuto BufWritePre,FileWritePre *?
    \ call vimrc#make_dir('<afile>:h', v:cmdbang)

" Modules
"---------------------------------------------------------------------------

  " Load configuration modules
  call vimrc#load_modules([
    \ 'encoding',
    \ 'gui',
    \ 'view',
    \ 'edit',
    \ 'statusline',
    \ 'mapping',
    \ 'abbr'
    \ ])

" Plugins
" ---------------------------------------------------------------------------

  " Disable default plugins
  let g:loaded_csv = 1
  let g:loaded_gzip = 1
  let g:loaded_zipPlugin = 1
  let g:loaded_tarPlugin = 1
  let g:loaded_logiPat = 1
  let g:loaded_matchit = 1
  let g:loaded_rrhelper = 1
  let g:loaded_matchparen = 1
  let g:loaded_parenmatch = 1
  let g:loaded_netrwPlugin = 1
  let g:loaded_2html_plugin = 1
  let g:loaded_vimballPlugin = 1
  let g:loaded_getscriptPlugin = 1
  let g:loaded_spellfile_plugin = 1
  let g:did_install_syntax_menu = 1
  let g:loaded_tutor_mode_plugin = 1
  let g:did_install_default_menus = 1

  " Load plugins
  call vimrc#load_plugins()
