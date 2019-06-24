"
" Plug Guidelines:
"
"   1. Plugins needs to fill a function and be useful
"   2. If a plugin requires configuration, the config should live in a dedicated
"     sourceable file, preferably in local plugin directory
"   3. Anything that requires a lot of effort without possible return should be
"     cut, even if it might be mentally challenging
"   4. Test plugins should have configs in this file, only transfer configs of
"     plugins I keep
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
    Plug 'mhartington/oceanic-next'

    " For highlight control
    " Plug 'Yggdroot/indentLine'
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
      Plug 'junegunn/fzf.vim'
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
    " Plug 'fatih/vim-go'
    Plug 'lifepillar/pgsql.vim'
    " let g:sql_type_default = 'sql'

    Plug 'Shougo/echodoc.vim' 

    Plug 'tpope/vim-fugitive'
    Plug 'liuchengxu/vista.vim'
    let g:vista_echo_cursor = 0
    let g:vista_echo_cursor_strategy = 'floating_win'
    let g:vista_close_on_jump = 1                                      

    Plug 'rhysd/git-messenger.vim'
    nmap <leader>gm <Plug>(git-messenger)

    Plug 'kassio/neoterm'

    " Plug 'tbabej/taskwiki'
    " Plug 'reedes/vim-pencil'
    " Plug 'tmhedberg/SimpylFold'
    " Plug 'thinca/vim-quickrun'

    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    Plug 'mg979/vim-bookmarks', {'branch': 'fzf'}

call plug#end()

if empty(s:plugged)
  autocmd! VimEnter * PlugInstall
endif

