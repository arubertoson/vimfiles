
if executable('fzf')
  Plug expand('$XDG_APP_HOME/fzf')
  Plug 'junegunn/fzf.vim'
endif

if executable('node')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'honza/vim-snippets' " Snippets, meant to work with coc
endif

" Terminal Util
Plug 'kassio/neoterm'

" Undo tree
Plug 'simnalamburt/vim-mundo'

" Quick comments
Plug 'tomtom/tcomment_vim'

" Provides a way to add, delete, switch surrounding brackets [test]->(test)
Plug 'machakann/vim-sandwich'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-textobj-delimited'
Plug 'AndrewRadev/splitjoin.vim'

" Nnvim in browser XXX how to run in wsl?
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
if exists('g:started_by_firenvim')
  packadd firenvim
endif
