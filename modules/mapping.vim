" Greatly inspired by: https://github.com/AlexMasterov/vimfiles
"---------------------------------------------------------------------------
" Mappings:

  let g:mapleader="\<Space>"
  let g:maplocalleader=";"
  
  nnoremap <Space>  <Nop>
  xnoremap <Space>  <Nop>
  nnoremap ,        <Nop>
  xnoremap ,        <Nop>
  nnoremap ;        <Nop>
  xnoremap ;        <Nop>
  nnoremap m        <Nop>
  xnoremap m        <Nop>


"---------------------------------------------------------------------------
" Normal Mode:

  " [jk]: don't skip wrap lines
  nnoremap <expr> j v:count ? 'j' : 'gj'
  nnoremap <expr> k v:count ? 'k' : 'gk'

  " Alt-[jkhl]: move selected lines
  nnoremap <A-h> <<<Esc>
  nnoremap <A-l> >>><Esc>
  nnoremap <silent> <A-j> :<C-u>move+1<CR>
  nnoremap <silent> <A-k> :<C-u>move-2<CR>

  " Ctrl-[jk]: scroll up/down 1/3 page
  nnoremap <expr> <C-j> v:count ?
    \ '<C-d>zz' : (winheight('.') / 4) . '<C-d>zz'
  nnoremap <expr> <C-k> v:count ?
    \ '<C-u>zz' : (winheight('.') / 4) . '<C-u>zz'

  " [oO]: append line
  nnoremap <silent> <expr> o v:count ?
    \ ':<C-u>call <SID>appendLineUp(v:count1)<CR>' : 'o'
  nnoremap <silent> <expr> O v:count ?
    \ ':<C-u>call <SID>appendLineDown(v:count1)<CR>' : 'O'

  " Ctrl-d: duplicate line
  nnoremap <expr> <C-d> 'yyp' . col('.') . 'l'

  " Q: auto indent text
  nnoremap Q ==

  " [cC]: don't update register
  nnoremap c "_c
  nnoremap C "_C

  " open vimrc in a new tab
  nnoremap <silent> <leader>ad :<C-u>edit $VIMFILES/vimrc<CR>
  nnoremap <silent> <leader>ap :<C-u>edit $VIMFILES/_vimrc.yaml<CR>

  " <leader>sr: replace a word under cursor
  nnoremap <leader>sr :%s/<C-R><C-w>//g<left><left>

  " :s::: is more useful than :s/// when replacing paths
  " https://github.com/jalanb/dotjab/commit/35a40d11c425351acb9a31d6cff73ba91e1bd272
  nnoremap <leader>sR :%s:<C-R><C-w>:<C-r><C-w>:<Left>

  " [*#]: with use 'smartcase'
  nnoremap * /\<<C-r>=expand('<cword>')<CR>\><CR>zv
  nnoremap # ?\<<C-r>=expand('<cword>')<CR>\><CR>zv

" Buffers
  " previous buffer
  nnoremap <silent> <leader>bp :<C-u>bprev<CR>
  " next buffer
  nnoremap <silent> <leader>bn :<C-u>bnext<CR>
  " delete buffer
  nnoremap <silent> <Space>bd :<C-u>bdelete<CR>
  " jump to alternate buffer
  nnoremap <silent> <leader>b<TAB> :<C-u>buffer#<CR>
  " new buffer
  nnoremap <silent> <leader>bt :<C-u>call <SID>makeBuffer()<CR>
  " smart close tab -> window -> buffer
  nnoremap <silent> <leader>bq :<C-u>call <SID>smartClose()<CR>

  " save file
  nnoremap <silent> <C-s> :<C-u>write<CR>

" Windows
  for char in split('h j k l')
    " Space + [hjkl]: jump to a window
    execute printf('nnoremap <silent> <localleader>%s :<C-u>wincmd %s<CR>', char, char)
    " Space + [HJKL]: move the current window
    execute printf('nnoremap <silent> <localleader>%s :<C-u>wincmd %s<CR>', toupper(char), toupper(char))
  endfor | unlet char
  " Space + w: next window
  " Space + r: rotate windows downwards / rightwards
  nnoremap <silent> <leader>wr :<C-u>wincmd r<CR>
  " Space + R: rotate windows upwards / leftwards
  nnoremap <silent> <leader>wR :<C-u>wincmd R<CR>
  " Space + v: split window horizontaly
  nnoremap <silent> <expr> <leader>wv ':<C-u>'. (v:count ? v:count : '') .'split<CR>'
  " Space + V: split window verticaly
  nnoremap <silent> <expr> <leader>wV ':<C-u>vertical '. (v:count ? v:count : '') .'split<CR>'
  " Space + m: move window to a new tab page
  nnoremap <silent> <leader>wm :<C-u>wincmd T<CR>

"---------------------------------------------------------------------------
" Visual Mode:

  " Alt-[jkhl]: move selected lines
  xnoremap <A-h> <'[V']
  xnoremap <A-l> >'[V']
  xnoremap <silent> <A-j> :move'>+1<CR>gv
  xnoremap <silent> <A-k> :move-2<CR>gv

"---------------------------------------------------------------------------
" Insert Mode:

  " Ctrl-u: undo
  inoremap <C-u> <C-o>u
  " Ctrl-s: save file
  inoremap <silent> <C-s> <Esc> :write<CR>i
  " Ctrl-c: fast Esc
  inoremap <C-c> <Esc>`^
  " Ctrl-l: fast Esc
  inoremap <C-l> <Esc>`^
  " [jj|qq]: smart fast Esc
  inoremap <expr> j getline('.')[getcurpos()[4]-2] ==# 'j' ? "\<BS>\<Esc>`^" : "\j"
  inoremap <expr> q getline('.')[getcurpos()[4]-2] ==# 'q' ? "\<BS>\<Esc>`^" : "\q"

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

  function! s:makeBuffer() abort
    let buffers = filter(range(1, bufnr('$')),
      \ 'buflisted(v:val) && "quickfix" !=? getbufvar(v:val, "&buftype")')
    execute ':badd buffer'. (max(buffers) + 1)
  endfunction

  function! s:smartClose() abort
    let tabPageNr = tabpagenr('$')
    if tabPageNr > 1
      tabclose | return
    endif
    if winnr('$') > 1
      let buffers = filter(tabpagebuflist(tabPageNr),
        \ 'bufname(v:val) =~? "vimfiler"')
      if empty(buffers)
        close | return
      endif
    endif
    if empty(bufname('#'))
      silent! bwipeout | return
    endif
    bprev | silent! bwipeout # | return
  endfunction
