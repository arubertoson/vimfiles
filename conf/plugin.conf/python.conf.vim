" Python:
"   
"   Create necessary environments required for neovim plugins to function
"   

let g:loaded_python_provider = 0

let s:pybin = "/envs/nvim3/bin/"

" My python developemnt environbment revolves around pyenv, if that is not
" available on the system I'm not really using python.
if executable('pyenv')
  let output = substitute(system('pyenv virtualenv-prefix nvim3'), '\n', '', 'g')
  if v:shell_error != 0
    let s:pyver = substitute(system("pyenv global"), '\n', '', 'g')
    execute '!pyenv virtualenv ' . s:pyver . ' nvim3'

    let output = substitute(system('pyenv virtualenv-prefix nvim3'), '\n', '', 'g')
  endif

  " Install pynvim module
  let s:pytest = system(output . s:pybin . 'python3 -c "import pynvim"')
  if v:shell_error != 0
    let res = system(output . s:pybin . 'pip3 install -U pip setuptools pynvim')
    if v:shell_error != 0
      echom "Failed to install nvim3 virualt environment: " . res
    endif
  endif 

  let g:python3_host_prog = output . s:pybin . 'python3'
  let pyx = 3
else
  let g:loaded_python3_provider = 0
endif

