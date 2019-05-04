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

    " Abspaths
    let s:conda_envs = expand('$CONDA_ENVS_PATH/nvim3/bin')
    let g:ale_python_black_executable = s:conda_envs . '/black'
    let g:ale_python_flake8_executable = s:conda_envs . '/flake8'
    let g:ale_python_pylint_executable = s:conda_envs . '/pylint'
    let g:ale_python_mypy_executable = s:conda_envs . '/mypy'

    " Fix on save
    let g:ale_fixers = {
      \ 'python': ['black', 'isort'],
      \ }
    let g:ale_fix_on_save = 1

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

  function! ConfigVimWiki()
                                  
    let mywiki = {}
    let mywiki.path = '/scratch/dev/gitlab.com/arubertoson/vimwiki/home'    
    let mywiki.syntax = 'markdown'
    let mywiki.ext = '.md'
    
    let workwiki = {}
    let workwiki.path = '/scratch/dev/gitlab.com/arubertoson/vimwiki/work'
    let workwiki.syntax = 'markdown'
    let workwiki.ext = '.md'

    

    let g:vimwiki_list = [mywiki, workwiki]
    let g:vimwiki_ext2syntax = {
      \ '.md': 'markdown',
      \ '.markdown': 'markdown',
      \ }
  endfunction

  function! _install_coc()
    CocInstall coc-json coc-yaml coc-python coc-snippets coc-html coc-css
    CocInstall https://github.com/arubertoson/vscode-snippets
  endfunction

  function! _coc()
    command! -nargs=0 PlugCocInstall call _install_coc()
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

  if executable('yarn')
    " Auto Completions & Tags
    Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()}} | call _coc()
  endif

  " XXX Test
  Plug 'tbabej/taskwiki'
  Plug 'reedes/vim-pencil'
  Plug 'tmhedberg/SimpylFold'
  Plug 'thinca/vim-quickrun'

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
      Gautocmd FileType json syntax match Comment +\/\/.\+$+
  Plug 'saltstack/salt-vim'
  Plug 'superfunc/usda-syntax' 
      Gautocmd BufRead,BufNewFile *.{usd[a]} set filetype=usda
      Gautocmd FileType usda source $VIMPATH/plugged/usda-syntax/vim/usda.vim
      "
  if executable('fzf')
    Plug '/scratch/opt/fzf'
    Plug 'junegunn/fzf.vim' | call ConfigFZF()
  endif

  Plug 'vimwiki/vimwiki', { 'branch': 'dev' } | call ConfigVimWiki()
  " XXX
  " PR pending:
  " Plug 'MattesGroeger/vim-bookmarks'
  Plug 'mg979/vim-bookmarks', {'branch': 'fzf'}

  if !empty($TMUX) 
    Plug 'christoomey/vim-tmux-navigator'
  endif

call plug#end()
