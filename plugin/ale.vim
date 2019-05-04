"
" ALE:
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" Interface:
"---------------------------------------------------------------------------

  set signcolumn=yes

  let g:ale_sign_error = '►'
  let g:ale_sign_warning = '»'
  let g:ale_statusline_format = ['× %d', '∆ %d', '♦ ok']


"---------------------------------------------------------------------------
" General:
"---------------------------------------------------------------------------

  let g:ale_lint_on_text_changed = 0
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_enter = 1
  let g:ale_fix_on_save = 1

  " Ale Active Linter/Fixer
  let g:ale_linters = {
    \ 'python': ['flake8', 'pydocstyle']
    \ }
  let g:ale_fixers = {
    \ 'python': ['black', 'isort'],
    \ }

  
"---------------------------------------------------------------------------
" Mapping:
"---------------------------------------------------------------------------

  nmap <silent> <leader><c-k> <plug>(ale_previous_wrap)
  nmap <silent> <leader><c-j> <plug>(ale_next_wrap)


"---------------------------------------------------------------------------
" Python:
"---------------------------------------------------------------------------

  let s:conda_envs = expand('$CONDA_ENVS_PATH/nvim3/bin')

  " Executables
  let g:ale_python_black_executable = s:conda_envs . '/black'
  let g:ale_python_flake8_executable = s:conda_envs . '/flake8'
  let g:ale_python_pydocstyle_executable = s:conda_envs . '/pydocstyle'

  " Linter Config
  let g:ale_python_flake8_options = '--ignore=E501'


