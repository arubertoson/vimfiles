
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
" Greatly inspired by: https://github.com/AlexMasterov/vimfiles
"---------------------------------------------------------------------------
" Mappings:
"---------------------------------------------------------------------------

  let g:mapleader="\<Space>"
  let g:maplocalleader=";"

  nnoremap <Space>  <Nop>
  xnoremap <Space>  <Nop>
  nnoremap ,        <Nop>
  xnoremap ,        <Nop>
  nnoremap ;        <Nop>
  xnoremap ;        <Nop>
  nnoremap q        <Nop>


"---------------------------------------------------------------------------
" Normal Mode:
"---------------------------------------------------------------------------

  " Exit
  nnoremap <silent> <leader>q :<C-u>call <SID>smartClose()<CR>
  nnoremap <silent> <leader>Q :<C-u>exit<CR>

  " [jk]: don't skip wrap lines
  nnoremap <expr> j v:count ? 'j' : 'gj'
  nnoremap <expr> k v:count ? 'k' : 'gk'

  " Alt-[jkhl]: move selected lines
  nnoremap <A-h> <<<Esc>
  nnoremap <A-l> >>><Esc>
  nnoremap <silent> <A-j> :<C-u>move+1<CR>
  nnoremap <silent> <A-k> :<C-u>move-2<CR>

  " Ctrl-[du]: scroll up/down half a page while centered
  nnoremap <expr> <C-d> v:count ?
    \ '<C-d>zz' : (winheight('.') / 2) . '<C-d>zz'
  nnoremap <expr> <C-u> v:count ?
    \ '<C-u>zz' : (winheight('.') / 2) . '<C-u>zz'

  " [oO]: append line
  nnoremap <silent> <expr> o v:count ?
    \ ':<C-u>call <SID>appendLineUp(v:count1)<CR>' : 'o'
  nnoremap <silent> <expr> O v:count ?
    \ ':<C-u>call <SID>appendLineDown(v:count1)<CR>' : 'O'

  " open vimrc in a new tab
  execute printf('nnoremap <silent> <leader>fer :<C-u>edit %s<CR>', g:vimpath.'/vimrc')
  execute printf('nnoremap <silent> <leader>fep :<C-u>edit %s<CR>', g:vimpath.'/conf/plugin.vim')
  execute printf('nnoremap <silent> <leader>fem :<C-u>edit %s<CR>', g:vimpath.'/conf/mapping.vim')

  " <leader>sr: replace a word under cursor
  nnoremap <leader>/r :%s:<C-R><C-w>::g<left><left>

  " :s::: is more useful than :s/// when replacing paths
  " https://github.com/jalanb/dotjab/commit/35a40d11c425351acb9a31d6cff73ba91e1bd272
  nnoremap <leader>/R :%s:<C-R><C-w>:<C-r><C-w>:<Left>

  " [*#]: with use 'smartcase'
  nnoremap * /\<<C-r>=expand('<cword>')<CR>\><CR>zv
  nnoremap # ?\<<C-r>=expand('<cword>')<CR>\><CR>zv

" Buffers
  nnoremap <silent> <leader><TAB> :<C-u>buffer#<CR>

" Windows
  for char in split('h j k l')
    " Control + [hjkl]: jump to a window
    execute printf('nnoremap <silent> <C-%s> :<C-u>wincmd %s<CR>', char, char)
    " Terminal
    execute printf('tnoremap <silent> <C-%s> <C-\><C-n>:<C-u>wincmd %s<CR>', char, char)
    " Control|Shift + [HJKL]: move the current window
    execute printf('nnoremap <silent> <localleader>%s :<C-u>wincmd %s<CR>', toupper(char), toupper(char))
    " 
  endfor | unlet char

  " rotate windows downwards / rightwards
  nnoremap <silent> <localleader>r :<C-u>wincmd r<CR>
  " rotate windows upwards / leftwards
  nnoremap <silent> <localleader>R :<C-u>wincmd R<CR>
  " split window horizontaly
  nnoremap <silent> <expr> <localleader>v ':<C-u>'. (v:count ? v:count : '') .'split<CR>'
  " split window verticaly
  nnoremap <silent> <expr> <localleader>V ':<C-u>vertical '. (v:count ? v:count : '') .'split<CR>'
  " move window to a new tab page
  nnoremap <silent> <localleader>t :<C-u>wincmd T<CR>
  nnoremap <silent> <localleader>o :<C-u> GoldenRatio<CR>

"---------------------------------------------------------------------------
" Visual Mode:

  " Alt-[jkhl]: move selected lines
  xnoremap <A-h> <'[V']
  xnoremap <A-l> >'[V']
  xnoremap <silent> <A-j> :move'>+1<CR>gv
  xnoremap <silent> <A-k> :move-2<CR>gv

"---------------------------------------------------------------------------
" Insert Mode:

  " Ctrl-s: save file
  inoremap <silent> <C-s> <Esc> :write<CR>i
  nnoremap <silent> <C-s> :<C-u>write<CR>

  inoremap jk <ESC>l
  inoremap kj <ESC>l

  " [jj|qq]: smart fast Esc
  " inoremap <expr> k getline('.')[getcurpos()[4]-2] ==# 'j' ? "\<BS>\<Esc>`^" : "\k"
  " inoremap <expr> j getline('.')[getcurpos()[4]-2] ==# 'k' ? "\<BS>\<Esc>`^" : "\j"

  " Unbinds
  inoremap <C-j> <Nop>
  inoremap <C-k> <Nop>

"---------------------------------------------------------------------------
" Command Mode:

  " Ctrl-h: previous char
  cnoremap <C-h> <Left>
  " Ctrl-l: next char
  cnoremap <C-l> <Right>
  " Ctrl-h: previous word
  cnoremap <A-h> <S-left>
  " Ctrl-h: next word
  cnoremap <A-l> <S-right>
  " Ctrl-j: previous history
  cnoremap <C-j> <Down>
  " Ctrl-k: next history
  cnoremap <C-k> <Up>
  " Ctrl-d: delete char
  cnoremap <C-d> <Del>
  " Ctrl-a: jump to head
  cnoremap <C-a> <Home>
  " Ctrl-e: jump to end
  cnoremap <C-e> <End>
  " Ctrl-v: open the command-line window
  cnoremap <C-v> <C-f>a


"---------------------------------------------------------------------------
" Functions:

  function! s:appendLineUp(line) abort
    for i in range(1, a:line)
      call append(line('.'), '')
    endfor
  endfunction

  function! s:appendLineDown(line) abort
    for i in range(1, a:line)
      call append(line('.') - 1, '')
    endfor
  endfunction

  function! s:smartClose() abort
    let tabPageNr = tabpagenr('$')
    if tabPageNr > 1
      tabclose | return
    endif

    if winnr('$') > 1
      if len(getbufinfo({'buflisted':1})) > 2
        bprev | silent! bwipeout # | return
      endif

      silent! close | return
    endif

    if empty(bufname('#'))
      silent! bwipeout | return
    endif
  endfunction
