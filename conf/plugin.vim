
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
"---------------------------------------------------------------------------
" Plugin Guidelines:
"
"   1. Plugins needs to fill a function and be useful
"   2. If a plugin requires configuration, the config should live in a dedicated
"     sourceable file.
"   3. Anything that requires a lot of effort without possible return should be
"     cut, even if it might be mentally challenging.
"   4. Plugins under test should have configs stored in this file
"
"---------------------------------------------------------------------------

  let s:plug_script = g:vimpath . '/autoload/plug.vim'
  let s:plugged = g:cachepath . '/plugged'
  let s:plugcfg = g:vimpath . '/plugin/config'
  let s:script_path = expand('<sfile>:p:h')

"---------------------------------------------------------------------------
" Vim Plug Install:
"---------------------------------------------------------------------------

if empty(glob(s:plug_script))
  silent execute '!curl -fLo ' . s:plug_script . ' --create-dirs' .
    \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif


call plug#begin(s:plugged)

  call vimrc#load_modules([
        \ 'style',
        \ 'syntax',
        \ 'util',
        \], s:script_path . "/plugin" )

  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  let g:semshi#error_sign = v:false

  Plug 'liuchengxu/vista.vim'
  Plug 'antoinemadec/coc-fzf'

  " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
  let g:vista#renderer#enable_icon = 1

  " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
  let g:vista#renderer#icons = {
  \   "function": "\uf794",
  \   "variable": "\uf71b",
  \  }
  
    " XXX remnants
    " Plug 'rhysd/git-messenger.vim'
    " nmap <leader>gm <Plug>(git-messenger) 
    " Plug 'tbabej/taskwiki' Plug
    " 'vimwiki/vimwiki', { 'branch': 'dev' }

  " Plug Config
  call vimrc#load_modules([
        \ 'fzf.conf',
        \ 'coc.conf',
        \ 'neoterm.conf',
        \ 'python.conf',
        \], s:script_path . "/plugin.conf" )

call plug#end()

