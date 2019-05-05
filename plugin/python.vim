
" Python:
"   
"   Create necessary environments required for neovim plugins to function
"   

" Install:
"---------------------------------------------------------------------------

  " Python Setup
  if executable('conda')
    " Python2 Setup
    let g:python_host_prog = resolve(expand('$CONDA_ENVS_PATH/nvim2')) . '/bin/python2'
    if !filereadable(g:python_host_prog)
      execute '!conda create -y -n nvim2 python=2 pip'
      execute '!' . fnamemodify(g:python_host_prog, ':p:h') . '/pip install pynvim'
    endif

    " Python3 Setup
    let g:python3_host_prog = resolve(expand('$CONDA_ENVS_PATH/nvim3')) . '/bin/python3'
    if !filereadable(g:python3_host_prog)
      execute '!conda create -y -n nvim3 python=3 pip'
      execute '!' . fnamemodify(g:python3_host_prog, ':p:h') . '/pip install pynvim'
      execute '!conda install --name -y nvim3 pylama black'
    endif
  endif

