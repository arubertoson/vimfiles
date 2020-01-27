"---------------------------------------------------------------------------
" Vimrc Functions:

function! vimrc#make_dir(name, ...) abort
  let force = a:0 >= 1 && a:1 ==# '!'
  let name = expand(a:name, 1)

  if !isdirectory(name)
    \ && (force || input('^y\%[es]$' =~? printf('"%s" does not exist. Create? [yes/no]', name)))
    silent call mkdir(iconv(name, &encoding, &termencoding), 'p')
  endif
endfunction


function! vimrc#load_modules(modules, path) abort
  let l:basedir = resolve(expand(a:path))
  for l:module in a:modules
    let l:modfile = l:basedir .'/'. l:module . '.vim'
    if filereadable(l:modfile)
      execute 'source' l:modfile
    endif
  endfor
endfunction


function! vimrc#set_theme(...) abort
  let l:theme_name = a:0 > 0 ? a:1 : g:vimrc#theme
  let l:theme = g:vimrc#themes[l:theme_name]

  " Use the original background
  let l:background = get(l:theme, 'background', 'dark')
  if l:background != &background
    execute 'set background=' . l:theme['background']
  endif

  " assume the colorscheme exists, else set a default
  let l:colorscheme = get(l:theme, 'colorscheme', 'desert')
  try
    " execute 'colorscheme ' . l:colorscheme
    call color#set(l:colorscheme)
  catch /E185:/
    " If no colorscheme use a default from vim
    call color#set('desert')
  endtry

  " Set font and linespace (only gui)
  if exists('g:GuiLoaded')
    let l:font = l:theme['typeface'] . ':h' . l:theme['font-size']
    let l:linespace = l:theme['linespace']

    execute 'GuiFont! ' . l:font
    execute 'GuiLinespace ' . l:theme['linespace']
  endif

  " Execute callback
  let l:cmd = get(l:theme, 'callback')
  if l:cmd
    execute l:cmd
  endif
endfunction

