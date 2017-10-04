

if exists('g:GuiLoaded')
  
  " Don't override colorscheme on reloading
  if !exists('g:colors_name')
    silent! call vimrc#set_theme(g:mamvim#theme)
  endif

  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

  set termguicolors

  call GuiMousehide(1)
  if exists('g:thematic#theme_name')
    let s:theme = g:thematic#themes[g:thematic#theme_name]
    let s:font = s:theme['typeface'] . ':h' . s:theme['font-size']

    execute "Guifont!" s:font
    execute 'GuiLinespace' s:theme['linespace']
  else
    GuiLinespace 3
    GuiFont! Droid Sans Mono:h11
  endif

 endif

