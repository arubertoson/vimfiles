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


function! vimrc#load_modules(modules) abort
  let l:basedir = resolve(expand('$VIMPATH/modules'))
  for l:module in a:modules
    let l:modfile = l:basedir .'/'. l:module . '.vim'
    if filereadable(l:modfile)
      execute 'source' l:modfile
    endif
  endfor
endfunction


function! vimrc#set_theme(...) abort
  let a:theme_name = a:0 > 0 ? a:1 : g:vimrc#theme
  let a:theme = g:vimrc#themes[a:theme_name]

  " Use the original background
  let l:background = get(a:theme, 'background', 'dark')
  if l:background != &background
    execute 'set background=' . a:theme['background']
  endif

  " assume the colorscheme exists, else set a default
  let l:colorscheme = get(a:theme, 'colorscheme', 'desert')
  try
    " execute 'colorscheme ' . l:colorscheme
    call color#set(l:colorscheme)
  catch /E185:/
    " If no colorscheme use a default from vim
    call color#set('desert')
  endtry

  " Set font and linespace
  let l:font = a:theme['typeface'] . ':h' . a:theme['font-size']
  let l:linespace = a:theme['linespace']
  if exists('g:GuiLoaded')
    execute 'GuiFont! ' . l:font
    execute 'GuiLinespace ' . a:theme['linespace']
  endif

  " Execute callback
  let l:cmd = get(a:theme, 'callback')
  if l:cmd
    execute l:cmd
  endif
endfunction


function! vimrc#auto_nohlsearch() abort
  nnoremap <silent> <Plug>(_auto-nohl) :<C-u>nohlsearch<CR>

  augroup auto-nohl
    autocmd!
    autocmd InsertEnter,CursorMoved * call feedkeys('\<Plug>(_auto-nohl)')
      \| autocmd! auto-nohl
  augroup END
endfunction

