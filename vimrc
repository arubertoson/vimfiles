"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
"---------------------------------------------------------------------------
" Environment Variables:

  let $XDG_CONFIG_HOME = expand($HOME.'/.config')
  let $XDG_CACHE_HOME = expand($HOME.'/.cache')
  let $XDG_DATA_HOME = expand($HOME.'/.local/share')
  let $XDG_RUNTIME_DIR = expand('/.local/runtime')

  let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p:h')), '')
  
  let $XDG_CONFIG_DIRS = expand('/etc/xdg')
  let $XDG_DATA_DIRS = expand('$HOME/.vim/miv/miv')

  set runtimepath^=$VIMPATH

"---------------------------------------------------------------------------
" Global AutoCmd:

  augroup vimrc | execute 'autocmd!' | augroup END
  command! -nargs=* Gautocmd autocmd vimrc <args>
  command! -nargs=* Gautocmdft autocmd vimrc FileType <args>

"---------------------------------------------------------------------------
" Global Commands:

  command! -nargs=1 Indent execute
    \ 'setlocal tabstop='.<q-args>
    \ 'softtabstop='.<q-args>
    \ 'shiftwidth='.<q-args>
  command! -nargs=0 -bar GoldenRatio exe 'vertical resize' &columns * 5 / 8
  " Shows the syntax stack under the cursor
  command! -bar SS echo 
    \ map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  " Set color theme
  command! -nargs=? SetColorScheme call vimrc#set_theme(<q-args>)

"---------------------------------------------------------------------------
" Global Events:

  " Optimize syntax in big files
  Gautocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

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
  Gautocmdft *? setlocal formatoptions=cmMj
  
  " Fix window position of help
  Gautocmd FileType help if &l:buftype ==# 'help' | wincmd K | endif

  " Always open read-only when a swap file is found
  Gautocmd SwapExists * let v:swapchoice = 'o'

  " Create directory if hierarchy doesn't exist
  Gautocmd BufWritePre,FileWritePre *?
    \ call vimrc#make_dir('<afile>:h', v:cmdbang)

"---------------------------------------------------------------------------
" Global Functions:

  function! IsWindows() abort
    return has('win64') || has('win32') || has('win32unix')
  endfunction

  function! IsUnix() abort
    return has('unix')
  endfunction

  function! IsMac() abort
    return !IsWindows()
          \ && (has('mac') || has('macunix') || has('gui_macvim')
          \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
  endfunction

  function! IsNvim() abort
    return has('nvim')
  endfunction

"---------------------------------------------------------------------------
" Global Settings:

  " Load configuration modules
  call vimrc#load_modules([
    \ 'encoding',
    \ 'general',
    \ 'view',
    \ 'mapping',
    \ 'abbr'
    \ ])

"---------------------------------------------------------------------------
" Global Plugins:

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
