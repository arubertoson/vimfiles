
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
"---------------------------------------------------------------------------
" Environment Variables:
"---------------------------------------------------------------------------

  let g:vimpath = fnamemodify(resolve(expand('<sfile>:p:h')), '') 
  let g:cachepath = $XDG_CACHE_HOME . '/nvim'

"---------------------------------------------------------------------------
" Global Functions:
"---------------------------------------------------------------------------

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
" Disable Default Plugins:
"---------------------------------------------------------------------------

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


"---------------------------------------------------------------------------
" Global Settings Modules:
"---------------------------------------------------------------------------

  if IsNvim() 
    call vimrc#load_modules(['neovim'], g:vimpath . 'conf')
  endif 

  " Load configuration modules
  call vimrc#load_modules([
    \ 'general',
    \ 'autocmd',
    \ 'mapping',
    \ 'command',
    \ 'plugin',
    \ 'style',
    \ ], g:vimpath . '/conf')

"---------------------------------------------------------------------------
" Post:
"---------------------------------------------------------------------------

  " Avoid running autocmds not owned by you in local .vimrc
  set secure



"  function IsBackListFiletypes() abort
"   if &filetype =~# '\v^(list|coc-explorer|cocactions)$'
"     return v:true
"   endif
"   return v:false
" endfunction
" 
" "使用绝对行号
" function! UserFuncAbsNum()
"   if IsBackListFiletypes()
"     return
"   endif
"   if !exists('#goyo')
"     set norelativenumber number
"   else
"     set norelativenumber nonumber
"   endif
" endfunction
"  "使用相对行号
" function! UserFuncRelNum()
"   if IsBackListFiletypes()
"     return
"   endif
"   if !exists('#goyo')
"     set relativenumber number
"   else
"     set norelativenumber nonumber
"   endif
" endfunction
