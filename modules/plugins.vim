"
" Plug Guidelines:
"
"   1. Plugins needs to fill a function and be useful
"   2. If a plugin requires configuration, the config should live in a dedicated
"     sourceable file, preferably in local plugin directory
"   3. Anything that requires a lot of effort without possible return should be
"     cut, even if it might be mentally challenging
"
"

  let s:plug_script = g:cachepath . '/autoload/plug.vim'
  let s:plugged = g:cachepath . '/plugged'
  let s:plugcfg = g:vimpath . '/plugin/config'

"---------------------------------------------------------------------------
" Vim Plug Install:
"---------------------------------------------------------------------------

  if empty(glob(s:plug_script))
    silent execute '!curl -fLo ' . s:plug_script . ' --create-dirs' .
      \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif


call plug#begin(s:plugged)

"---------------------------------------------------------------------------
" Interface:
"---------------------------------------------------------------------------
  
    " Themes
    Plug 'reedes/vim-colors-pencil'
    Plug 'ayu-theme/ayu-vim'

    " For highlight control
    Plug 'Yggdroot/indentLine'
    Plug 'romainl/vim-cool'

    Plug 'sheerun/vim-polyglot'
    Plug 'saltstack/salt-vim'
    "
    " Distraction Free Editing
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

"---------------------------------------------------------------------------
" Navigation:
"---------------------------------------------------------------------------

    if executable('fzf')
      Plug '/scratch/opt/fzf'
      Plug 'junegunn/fzf.vim' " | call ConfigFZF()
    endif
  
"---------------------------------------------------------------------------
" Language:
"---------------------------------------------------------------------------

    if executable('yarn')
      " Auto Completions
      Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()}}
    endif
    Plug 'w0rp/ale'

"---------------------------------------------------------------------------
" Tools:
"---------------------------------------------------------------------------
  
    " Quick comments
    Plug 'tomtom/tcomment_vim'
    " Smart input provides auto-pairs like behaviour to complete ()[]{} and other
    " inputs that require a secondary input to be considdered complete.
    Plug 'kana/vim-smartinput'
    " Provides a way to add, delete, switch surrounding brackets [test]->(test)
    Plug 'machakann/vim-sandwich'

"---------------------------------------------------------------------------
" Test:
"---------------------------------------------------------------------------

    Plug 'tbabej/taskwiki'
    Plug 'reedes/vim-pencil'
    Plug 'tmhedberg/SimpylFold'
    Plug 'thinca/vim-quickrun'

    Plug 'mg979/vim-bookmarks', {'branch': 'fzf'}
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

call plug#end()

if empty(s:plugged)
  autocmd! VimEnter * PlugInstall
endif

