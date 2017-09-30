" View
"---------------------------------------------------------------------------

set shortmess=aoOtTIcF
set number relativenumber    " show the line number
set nocursorline             " highlight the current line
set noequalalways            " resize windows as little as possible
set showtabline=0            " always show the tab pages
set hidden                   " allows the closing of buffers without saving
set switchbuf=useopen,split  " orders to open the buffer
set winminheight=0
set splitbelow splitright

" Ruler at 80 -> 120
let &colorcolumn="80,".join(range(120,400),",")

" Wrapping
if exists('+breakindent')
  set wrap                         " wrap long lines
  set linebreak                    " wrap without line breaks
  set breakindent                  " wrap lines, taking indentation into account
  set breakindentopt=shift:4       " indent broken lines
  set breakat=\ \ ;:,!?            " break point for linebreak
  set textwidth=0                  " do not wrap text
  set display+=lastline            " easy browse last line with wrap text
  set whichwrap=<,>,[,],h,l,b,s,~  " end/beginning-of-line cursor wrapping behave human-like
else
  set nowrap
  set sidescroll=1
endif

" Folding
set nofoldenable
" Diff
set diffopt=filler,iwhite,vertical

" Disable bell
set t_vb=
set belloff=all
set novisualbell

" Highlight invisible symbols
set nolist listchars=precedes:<,extends:>,nbsp:.,tab:+-,trail:•
" Avoid showing trailing whitespace when in Insert mode
let g:trailchar = matchstr(&listchars, '\(trail:\)\@<=\S')
MyAuto InsertEnter * execute 'setlocal listchars-=trail:' . g:trailchar
MyAuto InsertLeave * execute 'setlocal listchars+=trail:' . g:trailchar

" Title-line
set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" Command-line
set cmdheight=1
set noshowmode   " don't show the mode ('-- INSERT --') at the bottom
set wildmenu wildmode=longest,full
