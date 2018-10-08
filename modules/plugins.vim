"---------------------------------------------------------------------------
" Vim Plug Install:
"---------------------------------------------------------------------------

  if empty(glob('$VIMPATH/autoload/plug.vim'))
    silent !curl -fLo $VIMPATH/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

"---------------------------------------------------------------------------
" Config Functions:
"---------------------------------------------------------------------------

  function! ConfigGutentags()
    let g:gutentags_cache_dir = expand('$XDG_CACHE_HOME/gutentags')
    let g:gutentags_project_info = []
    call add(g:gutentags_project_info, {'type': 'python', 'file': 'package.py'})

    " let g:gutentags_trace = 1
    let g:gutentags_ctags_exclude = ['tests/*', 'test/*', '_*']

    let g:gutentags_file_list_command = {
      \ 'markers': {
        \ '.git': 'git ls-files',
        \ }
      \ }
  endfunction

  function! ConfigIndentLine()
    " Setup for IndentLine Plugin
    let g:indentLine_char = '¦'
    let g:indentLine_showFirstIndentLevel = 0
    " let g:indentLine_leadingSpaceChar = '·'
    let g:indentLine_leadingSpaceEnabled = 0
    let g:indentLine_setColors = 1
    let g:indentLine_fileTypeExclude = ['md', 'markdown', 'json']
  endfunction

  function! ConfigAle()
    " Gutter signs
    let g:ale_sign_error = '►'
    let g:ale_sign_warning = '»'
    let g:ale_statusline_format = ['× %d', '∆ %d', '♦ ok']

    " Only lint on save
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_insert_leave = 0
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_enter = 1

    " Linters
    let g:ale_python_pyls_executable = "/storage/software/opt/miniconda/envs/nvim37/bin/pyls"
    let g:ale_linters = {
      \ 'python': ['pyls']
      \ }

    " Fixers
    let g:ale_fix_on_save = 1

    let g:ale_python_yapf_executable = "/storage/software/opt/miniconda/envs/nvim37/bin/yapf" 
    let g:ale_python_isort_executable = "/storage/software/opt/miniconda/envs/nvim37/bin/isort"  
    let g:ale_fixers = {
      \ 'python': ['isort', 'yapf'],
      \ }

    nmap <silent> <Leader><C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <Leader><C-j> <Plug>(ale_next_wrap)
  endfunction

  function! ConfigAyu()
    " Custom theme settings
    let g:ayucolor="mirage"
    " Ayu theme overrides for ale gutter marks
    Gautocmd ColorScheme *
      \  hi ALEErrorSign   guifg=#FF3333 guibg=#242B38 gui=bold
      \| hi ALEWarningSign guifg=#FFCC66 guibg=#242B38 gui=bold
  endfunction


  function! ConfigFZF()
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \ <bang>0 ? fzf#vim#with_preview('up:60%')
      \         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \ <bang>0)

    " File Jumping
    nnoremap <leader>of :Files<CR>
    nnoremap <leader>og :GFiles<CR>
    nnoremap <leader>ob :Buffers<CR>
    nnoremap <leader>oh :Helptags<CR>
    nnoremap <leader>ot :BTags<CR>
    
    " Tags
    nnoremap <leader>sh :History<CR>
    nnoremap <leader>sm :FzfBookmarks<CR>
    nnoremap <leader>st :Tags<CR>

    " Searching
    nnoremap <leader>ss :BLines<CR>
    nnoremap <leader>sl :Lines<CR>
    nnoremap <leader>sr :Rg<CR>

    " Others
    nnoremap <leader>ft :Filetypes<CR>
    nnoremap <leader>fc :Colors<CR>
  endfunction

"---------------------------------------------------------------------------
" Vim Plugin Installs:
"---------------------------------------------------------------------------

call plug#begin('$VIMPATH/plugged')

  " Quick comments
  Plug 'tomtom/tcomment_vim'
  " Smart input provides auto-pairs like behaviour to complete ()[]{} and other
  " inputs that require a secondary input to be considdered complete.
  Plug 'kana/vim-smartinput'
  " Provides a way to add, delete, switch surrounding brackets [test]->(test)
  Plug 'machakann/vim-sandwich'
  " For search highlight control
  Plug 'romainl/vim-cool'

  " Auto Completions & Tags
  Plug 'Valloric/YouCompleteMe'

  if executable('ctags')
    Plug 'ludovicchabant/vim-gutentags' | call ConfigGutentags()
  endif

  " XXX Test
  Plug 'reedes/vim-pencil'
  Plug 'tmhedberg/SimpylFold'
  Plug 'thinca/vim-quickrun'
  Plug 'JamshedVesuna/vim-markdown-preview'
    let vim_markdown_preview_github=1
  Plug 'sjl/gundo.vim'
  Plug 'ToruIwashita/git-switcher.vim'
  " XXX
  " Modify C-K keys in init#maps
  " Plug 'mg979/vim-yanktools'


  " Distraction Free Editing
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  " Linters
  Plug 'w0rp/ale' | call ConfigAle()

  " Themes
  Plug 'reedes/vim-colors-pencil'
  Plug 'ayu-theme/ayu-vim' | call ConfigAyu()
  Plug 'Yggdroot/indentLine' | call ConfigIndentLine()


  " USD syntax highlighting
  Plug 'sheerun/vim-polyglot'
  Plug 'superfunc/usda-syntax' 
      Gautocmd BufRead,BufNewFile *.{usd[a]} set filetype=usda
      Gautocmd FileType usda source $VIMPATH/plugged/usda-syntax/vim/usda.vim
  " clang syntax highlighting
  Plug 'arakashic/chromatica.nvim'


  Plug 'junegunn/fzf', { 'dir': '/scratch/opt/fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim' | call ConfigFZF()

  Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
  " XXX
  " PR pending:
  " Plug 'MattesGroeger/vim-bookmarks'
  Plug 'mg979/vim-bookmarks', {'branch': 'fzf'}

call plug#end()
