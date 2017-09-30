" Edit
"--------------------------------------------------------------------------

" Do not wait more than 100 ms for keys
set timeout
set ttimeout ttimeoutlen=100

set report=0             " reporting number of lines changes
set lazyredraw           " don't redraw while executing macros
set nostartofline        " avoid moving cursor to BOL when jumping around
set virtualedit=all   " allows the cursor position past true end of line
" set clipboard=unnamed  " use * register for copy-paste

" Indent
set cindent          " smart indenting for c-like code
set autoindent       " indent at the same level of the previous line
set shiftround       " indent multiple of shiftwidth
set expandtab        " spaces instead of tabs
set tabstop=2        " number of spaces per tab for display
set shiftwidth=2     " number of spaces per tab in insert mode
set softtabstop=2    " number of spaces when indenting
set nojoinspaces     " prevents inserting two spaces after punctuation on a join (J)
set backspace=indent,eol,start

" Search
set smartcase
set ignorecase
set hlsearch         " highlight search results
set incsearch        " find as you type search
set gdefault         " flag 'g' by default for replacing
set magic            " change the way backslashes are used in search patterns

" Autocomplete
set pumheight=10
set complete=. completeopt=longest

" Wildmenu
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

 " History saving
set history=2000
if has('nvim')
	"  ShaDa/viminfo:
	"   ' - Maximum number of previously edited files marks
	"   < - Maximum number of lines saved for each register
	"   @ - Maximum number of items in the input-line history to be
	"   s - Maximum size of an item contents in KiB
	"   h - Disable the effect of 'hlsearch' when loading the shada
	set shada='300,<10,@50,s100,h
endif
