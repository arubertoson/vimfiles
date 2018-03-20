"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
"---------------------------------------------------------------------------
" Environment Variables:

  let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p:h')), '')
  let $VIMDATA = expand('$HOME/.vim/miv/miv')
  " let $VIMRUNTIME = expand('$HOME/.local')
  
  set runtimepath^=$VIMPATH

  "
  " This is per workstation expect this to change at different locations 
  let g:python_host_prog = resolve(expand('~/.conda/envs/nvim27')) . '/bin/python2'
  let g:python3_host_prog = resolve(expand('~/.conda/envs/nvim36')) . '/bin/python3'

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

  " Disable Default Plugins
  let g:did_install_default_menus = 1 " $VIMRUNTIME/menu.vim
  let g:did_menu_trans            = 1 " $VIMRUNTIME/menu.vim
  let g:load_doxygen_syntax       = 1 " $VIMRUNTIME/syntax/doxygen.vim
  let g:loaded_2html_plugin       = 1 " $VIMRUNTIME/plugin/tohtml.vim
  let g:loaded_gzip               = 1 " $VIMRUNTIME/plugin/gzip.vim
  let g:loaded_less               = 1 " $VIMRUNTIME/macros/less.vim
  let g:loaded_matchit            = 1 " $VIMRUNTIME/plugin/matchit.vim
  let g:loaded_matchparen         = 1 " $VIMRUNTIME/plugin/matchparen.vim
  let g:loaded_netrw              = 1 " $VIMRUNTIME/autoload/netrw.vim
  let g:loaded_netrwFileHandlers  = 1 " $VIMRUNTIME/autoload/netrwFileHandlers.vim
  let g:loaded_netrwPlugin        = 1 " $VIMRUNTIME/plugin/netrwPlugin.vim
  let g:loaded_netrwSettings      = 1 " $VIMRUNTIME/autoload/netrwSettings.vim
  let g:loaded_rrhelper           = 1 " $VIMRUNTIME/plugin/rrhelper.vim
  let g:loaded_spellfile_plugin   = 1 " $VIMRUNTIME/plugin/spellfile.vim
  let g:loaded_sql_completion     = 1 " $VIMRUNTIME/autoload/sqlcomplete.vim
  let g:loaded_syntax_completion  = 1 " $VIMRUNTIME/autoload/syntaxcomplete.vim
  let g:loaded_tar                = 1 " $VIMRUNTIME/autoload/tar.vim
  let g:loaded_tarPlugin          = 1 " $VIMRUNTIME/plugin/tarPlugin.vim
  let g:loaded_tutor_mode_plugin  = 1 " $VIMRUNTIME/plugin/tutor.vim
  let g:loaded_vimball            = 1 " $VIMRUNTIME/autoload/vimball.vim
  let g:loaded_vimballPlugin      = 1 " $VIMRUNTIME/plugin/vimballPlugin
  let g:loaded_zip                = 1 " $VIMRUNTIME/autoload/zip.vim
  let g:loaded_zipPlugin          = 1 " $VIMRUNTIME/plugin/zipPlugin.vim
  let g:myscriptsfile             = 1 " $VIMRUNTIME/scripts.vim
  let g:netrw_nogx                = 1
  let g:suppress_doxygen          = 1 " $VIMRUNTIME/syntax/doxygen.vim
  
"  if IsNvim()
"    " Load User Plugins
"    call vimrc#load_plugins()
"  endif

"---------------------------------------------------------------------------
" Vim Plug:

  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  call plug#begin('~/.vim/plugged')

    " Quick comments
    Plug 'tomtom/tcomment_vim'
    " Smart input provides auto-pairs like behaviour to complete ()[]{} and other
    " inputs that require a secondary input to be considdered complete.
    Plug 'kana/vim-smartinput'
    " Provides a way to add, delete, switch surrounding brackets [test]->(test)
    Plug 'machakann/vim-sandwich'
    " For search highlight control
    Plug 'romainl/vim-cool'

    " Distractionfree editing
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

    " Auto complete
    Plug 'roxma/nvim-completion-manager'

    " Linters
    Plug 'w0rp/ale'
      " Gutter signs
      let g:ale_sign_error = '►'
      let g:ale_sign_warning = '»'
      let g:ale_statusline_format = ['× %d', '∆ %d', '♦ ok']

      " Only lint on save
      let g:ale_lint_on_text_changed = 0
      let g:ale_lint_on_insert_leave = 0
      let g:ale_lint_on_save = 1
      let g:ale_lint_on_enter = 1

      " Fix on save
      let g:ale_fixers = {
        \ 'python': ['yapf'],
        \ }
      let g:ale_fix_on_save = 1

    " Themes
    Plug 'reedes/vim-colors-pencil'
    Plug 'ayu-theme/ayu-vim'
      " Custom theme settings
      let g:ayucolor="mirage"
      " Ayu theme overrides for ale gutter marks
      Gautocmd ColorScheme *
        \  hi ALEErrorSign   guifg=#FF3333 guibg=#242B38 gui=bold
        \| hi ALEWarningSign guifg=#FFCC66 guibg=#242B38 gui=bold

    Plug 'Yggdroot/indentLine'
      let g:indentLine_char = '¦'
      let g:indentLine_showFirstIndentLevel = 0
      let g:indentLine_leadingSpaceChar = '·'
      let g:indentLine_leadingSpaceEnabled = 1
      let g:indentLine_setColors = 1
      let g:indentLine_fileTypeExclude = ['md', 'markdown', 'json']

    " USD syntax highlighting
    Plug 'superfunc/usda-syntax' 
        Gautocmd BufRead,BufNewFile *.{usd[a]} set filetype=usda
        Gautocmd FileType usda source $VIMPATH/plugged/usda-syntax/vim/usda.vim

    " clang syntax highlighting
    Plug 'arakashic/chromatica.nvim'


  call plug#end()

  " Set default theme and other themes that we can change to
  let g:vimrc#theme = 'icode'
  let g:vimrc#themes = {
    \   'iwrite': { 'colorscheme': 'pencil',
    \              'background': 'light',
    \              'font-size': '14',
    \              'linespace': '6',
    \              'typeface': 'Cousine',
    \               },
    \   'icode': { 'colorscheme': 'ayu',
    \              'background': 'dark',
    \              'font-size': '12',
    \              'linespace': '3',
    \              'typeface': 'Droid Sans Mono',
    \               },
    \ }
  
  if !has('gui_running')
    SetColorScheme icode
  endif


"---------------------------------------------------------------------------
" Post:

  " Avoid running autocmds not owned by you in local .vimrc
  set secure                

