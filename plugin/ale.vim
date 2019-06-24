"
" ALE:
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" Interface:
"---------------------------------------------------------------------------


  let g:ale_sign_error = '►'
  let g:ale_sign_warning = '»'
  let g:ale_sign_info = 'i'
  let g:ale_statusline_format = ['× %d', '∆ %d', '♦ ok']

  let g:ale_sign_style_error = 's'
  let g:ale_sign_style_warning = 's'

"---------------------------------------------------------------------------
" General:
"---------------------------------------------------------------------------

  set signcolumn=yes
  let g:ale_sign_column_always = 1

  let g:ale_lint_on_text_changed = 0
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 1
  let g:ale_fix_on_save = 1

  call ale#linter#Define('go', {
    \ 'name': 'revive',
    \ 'output_stream': 'both',
    \ 'executable': 'revive',
    \ 'read_buffer': 0,
    \ 'command': 'revive %t',
    \ 'callback': 'ale#handlers#unix#HandleAsWarning',
    \})

  " Ale Active Linter/Fixer
  let g:ale_linters = {
    \ 'python': ['flake8', 'pydocstyle'],
    \ 'go': ['revive', 'golangci-lint'],
    \ }
  let g:ale_fixers = {
    \ 'python': ['black', 'isort'],
    \ 'go': ['gofmt'],
    \ }

  
"---------------------------------------------------------------------------
" Mapping:
"---------------------------------------------------------------------------

  nmap <silent> <leader>lp <plug>(ale_previous_wrap)
  nmap <silent> <leader>ln <plug>(ale_next_wrap)


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


