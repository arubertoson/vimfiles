
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
"---------------------------------------------------------------------------
" General Settings:
"---------------------------------------------------------------------------

let $CACHEPATH = g:cachepath

"---------------------------------------------------------------------------
" General Settings: {{{
  set exrc                     " avoid reading local (g)vimrc, exrc

  set mouse=nv                 " Disable mouse in command-line mode
  set mousehide
  set modeline                 " automatically setting options from modelines
  set lazyredraw               " don't redraw while executing macros
  set report=0                 " Don't report on line changes
  set hidden                   " hide buffers when abandoned instead of unload
  set magic                    " For regular expressions turn magic on
  set regexpengine=2           " 0=auto 1=old 2=NFA
  set path=.,**                " Directories to search when using gf
  set virtualedit=all          " Position cursor anywhere in visual block
  set synmaxcol=200            " Don't syntax highlight long lines
  set formatoptions+=1         " Don't break lines after a one-letter word
  set formatoptions-=t         " Don't auto-wrap text
  set formatoptions+=j         " Remove comment leader when joining lines
" }}}

"---------------------------------------------------------------------------
" Encoding: {{{

  set encoding=utf-8
  scriptencoding utf-8
  set fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
  set fileformat=unix
  set fileformats=unix,dos,mac 

  if IsWindows()
    set termencoding=cp850           " cmd.exe uses cp850
  else
    set termencoding=                " same as 'encoding'
  endif
" }}}

"---------------------------------------------------------------------------
" Directories: {{{

  set undofile swapfile nobackup nowritebackup
  set directory=$CACHEPATH/swap//,$CACHEPATH,
  set undodir=$CACHEPATH/undo//,$CACHEPATH,
  set backupdir=$CACHEPATH/backup//,$CACHEPATH,
  set viewdir=$CACHEPATH/view
  set nospell spellfile=$CACHEPATH/spell/en.utf-8.add
  set packpath=

  if IsNvim()
    "  ShaDa/viminfo:
    "   ' - Maximum number of previously edited files marks
    "   < - Maximum number of lines saved for each register
    "   @ - Maximum number of items in the input-line history to be
    "   s - Maximum size of an item contents in KiB
    "   h - Disable the effect of 'hlsearch' when loading the shada
    set shada='300,<10,@50,s100,h
  endif

  " History saving
  set history=2000
" }}}

"---------------------------------------------------------------------------
" Behaviour Settings: {{{

  set autoread                        " Automatically update buffer from outside changes
  set nowrap                          " No wrap by default
  set linebreak                       " Break long lines at 'breakat'
  set breakat=\ \	;:,!?               " Long lines break chars
  set nostartofline                   " Cursor in same column for few commands
  set whichwrap+=h,l,<,>,[,],~        " Move to following line on certain keys
  set splitbelow splitright           " Splits open bottom right
  set switchbuf=useopen,usetab        " Jump to the first open window in any tab
  set backspace=indent,eol,start      " Intuitive backspacing in insert mode
  set diffopt=filler,iwhite,vertical  " Diff mode: show fillers, ignore white
  set showfulltag                     " Show tag and tidy search in completion
  set complete=.                      " No wins, buffs, tags, include scanning
  set completeopt+=menuone            " Show menu even for one item
  set completeopt+=longest            " Complete the longest common text


  if has('wildmenu')
    " set nowildmenu
    set wildmode=list:longest,full
    set wildoptions=tagfile
    set wildignorecase
    set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
    set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
    set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
    set wildignore+=__pycache__,*.egg-info
  endif

  if has('clipboard')
    set clipboard& clipboard+=unnamedplus  " Clipboard for all operations
  endif

  set timeout ttimeout
  set timeoutlen=750    " Time out on mappings
  set updatetime=300   " Idle time to write swap and trigger CursorHold

"---------------------------------------------------------------------------
" Session Settings:
"---------------------------------------------------------------------------

  " What to save for views:
  set viewoptions-=options
  set viewoptions+=slash,unix

  " set viewoptions=folds,options,cursor,unix,slash
  " set virtualedit=onemore
  
  " What to save in sessions:
  set sessionoptions-=blank
  set sessionoptions-=options
  set sessionoptions-=globals
  set sessionoptions-=folds
  set sessionoptions-=help
  set sessionoptions-=buffers
  set sessionoptions+=tabpages

