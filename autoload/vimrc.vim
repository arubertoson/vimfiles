" vimrc functions
"---------------------------------------------------------------------------

function! vimrc#make_dir(name, ...) abort
  let force = a:0 >= 1 && a:1 ==# '!'
  let name = expand(a:name, 1)

  if !isdirectory(name)
    \ && (force || input('^y\%[es]$' =~? printf('"%s" does not exist. Create? [yes/no]', name)))
    silent call mkdir(iconv(name, &encoding, &termencoding), 'p')
  endif
endfunction


function! vimrc#load_modules(modules) abort
  let l:basedir = resolve(expand('$VIMFILES/modules/'))
  for l:module in a:modules
    let l:modfile = l:basedir . l:module . '.vim'
    if filereadable(l:modfile)
      execute 'source' l:modfile
    endif
  endfor
endfunction


function! vimrc#load_plugins() abort
  filetype off
  if has('vim_starting')
    let &runtimepath= expand($MIVFILES) . ',' . &runtimepath
  endif
  filetype plugin indent on
  silent! syntax enable
endfunction


function! vimrc#set_theme(...) abort
  let a:theme_name = a:0 > 0 ? a:1 : g:mamvim#theme
  let a:theme = g:mamvim#themes[a:theme_name]

  " Use the original background
  let l:background = get(a:theme, 'background', 'dark')
  if l:background != &background
    execute 'set background=' . a:theme['background']
  endif

  " assume the colorscheme exists, else set a default
  let l:colorscheme = get(a:theme, 'colorscheme', 'desert')
  try
    execute 'MyColorscheme ' .  l:colorscheme
    " execute 'colorscheme ' . l:colorscheme
  catch /E185:/
    " If no colorscheme use a default from vim
    execute 'MyColorscheme ' . 'desert'
  endtry

  " Set font and linespace
  let l:font = a:theme['typeface'] . ':h' . a:theme['font-size']
  let l:linespace = a:theme['linespace']
  if exists('g:GuiLoaded')
    execute 'GuiFont! ' . l:font
    execute 'GuiLinespace ' . a:theme['linespace']
  endif
endfunction

