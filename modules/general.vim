" Greatly inspired by rafi: https://github.com/rafi/vim-config
"---------------------------------------------------------------------------
" General Settings:

  set exrc                     " avoid reading local (g)vimrc, exrc
  if IsNvim()
    set packpath=
  endif

  set mouse=nv                 " Disable mouse in command-line mode
  set modeline                 " automatically setting options from modelines
  set lazyredraw               " don't redraw while executing macros
  set report=0                 " Don't report on line changes
  set errorbells               " Trigger bell on error
  set visualbell               " Use visual bell instead of beeping
  set hidden                   " hide buffers when abandoned instead of unload
  set magic                    " For regular expressions turn magic on
  set regexpengine=2           " 0=auto 1=old 2=NFA
  set path=.,**                " Directories to search when using gf
  set virtualedit=all          " Position cursor anywhere in visual block
  set synmaxcol=1000           " Don't syntax highlight long lines
  set formatoptions+=1         " Don't break lines after a one-letter word
  set formatoptions-=t         " Don't auto-wrap text
  set formatoptions+=j         " Remove comment leader when joining lines

"---------------------------------------------------------------------------
" Directories:

  set undofile swapfile nobackup
  set directory=$XDG_CACHE_HOME/swap//,$XDG_CACHE_HOME,
  set undodir=$XDG_CACHE_HOME/undo//,$XDG_CACHE_HOME,
  set backupdir=$XDG_CACHE_HOME/backup//,$XDG_CACHE_HOME,
  set viewdir=$XDG_CACHE_HOME/view
  set nospell spellfile=$VIMPATH/spell/en.utf-8.add

  " History saving
  set history=2000
  if IsNvim()
  	"  ShaDa/viminfo:
  	"   ' - Maximum number of previously edited files marks
  	"   < - Maximum number of lines saved for each register
  	"   @ - Maximum number of items in the input-line history to be
  	"   s - Maximum size of an item contents in KiB
  	"   h - Disable the effect of 'hlsearch' when loading the shada
  	set shada='300,<10,@50,s100,h
  else
  	set viminfo='300,<10,@50,h,n$XDG_CACHE_HOME/viminfo
  endif

"---------------------------------------------------------------------------
" Behaviour Settings:

  set nowrap                          " No wrap by default
  set linebreak                       " Break long lines at 'breakat'
  set breakat=\ \	;:,!?               " Long lines break chars
  set nostartofline                   " Cursor in same column for few commands
  set whichwrap+=h,l,<,>,[,],~        " Move to following line on certain keys
  set splitbelow splitright           " Splits open bottom right
  set switchbuf=useopen,usetab        " Jump to the first open window in any tab
  if IsNvim()
    set switchbuf+=vsplit               " Switch buffer behavior to vsplit
  endif
  set backspace=indent,eol,start      " Intuitive backspacing in insert mode
  set diffopt=filler,iwhite,vertical  " Diff mode: show fillers, ignore white
  set showfulltag                     " Show tag and tidy search in completion
  set complete=.                      " No wins, buffs, tags, include scanning
  set completeopt=menuone             " Show menu even for one item
  set completeopt=longest             " Complete the longest common text
  if IsNvim()
    set completeopt+=noselect           " Do not select a match in the menu
    set completeopt+=noinsert           " Do not insert any text
  endif

  if has('wildmenu')
    set nowildmenu
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
  set updatetime=1000   " Idle time to write swap and trigger CursorHold

"---------------------------------------------------------------------------
" Session Settings:

  " What to save for views:
  set viewoptions-=options
  set viewoptions+=slash,unix
  
  " What to save in sessions:
  set sessionoptions-=blank
  set sessionoptions-=options
  set sessionoptions-=globals
  set sessionoptions-=folds
  set sessionoptions-=help
  set sessionoptions-=buffers
  set sessionoptions+=tabpages
