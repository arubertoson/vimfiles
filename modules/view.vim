" Greatly inspired by rafi: https://github.com/rafi/vim-config
"---------------------------------------------------------------------------
" View:

  set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
  
  set noshowmode               " Don't show mode in cmd window
  set shortmess=aoOtTIcF       " shorten messages
  set scrolloff=2              " Keep at least 2 lines above/below
  set sidescrolloff=5          " Keep at least 5 lines left/right
  set number relativenumber    " show the line number
  set noruler                  " Disable default status ruler
  set list                     " Show hidden characters
  
  set showtabline=2            " Always show the tabs line
  set winwidth=30              " Minimum width for active window
  set winheight=1              " Minimum height for active window
  set pumheight=15             " Pop-up menu's line height
  set helpheight=12            " Minimum help window height
  set previewheight=12         " Completion preview height
  
  set noshowcmd                " Don't show command in status line
  set cmdheight=2              " Height of the command line
  set cmdwinheight=5           " Command-line lines
  set noequalalways            " Don't resize windows on split or close
  set laststatus=2             " Always show a status line
  set colorcolumn=80           " Highlight the 80th character limit
  set display=lastline
  
  set nocursorline             " highlight the current line
  set nofoldenable             " No folding
  

"---------------------------------------------------------------------------
" Tabs Indents:

  set cindent         " smart indenting for c-like code
  set textwidth=80    " Text width maximum chars before wrapping
  set expandtab       " Don't expand tabs to spaces.
  set tabstop=2       " The number of spaces a tab is
  set softtabstop=2   " While performing editing operations
  set shiftwidth=2    " Number of spaces to use in auto(indent)
  set smarttab        " Tab insert blanks according to 'shiftwidth'
  set autoindent      " Use same indenting on new lines
  set smartindent     " Smart autoindenting on new lines
  set shiftround      " Round indent to multiple of 'shiftwidth'
  set nojoinspaces    " prevents inserting two spaces after join

"---------------------------------------------------------------------------
" Searching:

  set ignorecase      " Search ignoring case
  set smartcase       " Keep case when searching with *
  set infercase       " Adjust case in insert completion mode
  set incsearch       " Incremental search
  set hlsearch        " Highlight search results
  set wrapscan        " Searches wrap around the end of the file
  set showmatch       " Jump to matching bracket
  set matchpairs+=<:> " Add HTML brackets to pair matching
  set matchtime=1     " Tenths of a second to show the matching paren
  set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed

  if IsNvim()
    set inccommand=split
  endif

"---------------------------------------------------------------------------
" GUI:

  " Nvim configs lives in ginit.vim
  " TODO: Move this functionality together with SetColorScheme
  
  if has('gui_running')
    if has('vim_starting')
      winsize 190 30 | winpos 492 372
    endif
    set guioptions=ac
    set guicursor=a:blinkon0  " turn off blinking cursor
    set linespace=4           " extra spaces between rows
  
    if IsWindows()
      set guifont=Droid_Sans_Mono:h10,Consolas:h11
    else
      set guifont=Droid\ Sans\ Mono\ 10,Consolas\ 11
    endif
  
    " DirectWrite
    if IsWindows() && has('directx')
      set renderoptions=type:directx,gamma:2.2,contrast:0.5,level:0.5
        \ ,geom:1,renmode:3,taamode:2
    endif
  endif
