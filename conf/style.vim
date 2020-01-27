
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
" Global Style:
"---------------------------------------------------------------------------

  set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
  
  if IsNvim()
    set termguicolors            " Use gui colors in terminal
    set shortmess=aoOtTIcF       " shorten messages

    set inccommand=split
  endif
  set noshowmode               " Don't show mode in cmd window
  set scrolloff=2              " Keep at least 2 lines above/below
  set sidescrolloff=5          " Keep at least 5 lines left/right
  set relativenumber
  set number                   " show the line number
  set noruler                  " Disable default status ruler
  set list                     " Show hidden characters
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
  
  set signcolumn=yes
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
  set colorcolumn=100          " Highlight the 80th character limit
  set display=lastline
  
  set cursorline               " highlight the current line (no)
  set nofoldenable             " No folding
  
"---------------------------------------------------------------------------
" Tabs Indents:

  set cindent         " smart indenting for c-like code
  set textwidth=80    " Text width maximum chars before wrapping
  set expandtab       " Don't expand tabs to spaces.
  set tabstop=4       " The number of spaces a tab is
  set softtabstop=4   " While performing editing operations
  set shiftwidth=4    " Number of spaces to use in auto(indent)
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

"---------------------------------------------------------------------------
" AutoGroups:

augroup StyleAU
  autocmd!
  autocmd ColorScheme * call s:init()
augroup END

function s:init() abort
  highlight! link Visual Cursor
  highlight! link SignColumn LineNr
  highlight! link VisualNOS Cursor
  highlight! link IncSearch WildMenu
  highlight! link Search WildMenu
endfunction

"---------------------------------------------------------------------------
" ColorScheme:
"---------------------------------------------------------------------------
" Set default theme and other themes that we can change to
let g:vimrc#theme = 'ocean'
let g:vimrc#themes = {
  \   'iwrite': { 'colorscheme': 'pencil',
  \              'background': 'light',
  \              'font-size': '14',
  \              'linespace': '6',
  \              'typeface': 'Cousine',
  \               },
  \   'icode': { 'colorscheme': 'ayu',
  \              'background': 'dark',
  \              'font-size': '12',
  \              'linespace': '3',
  \              'typeface': 'Droid Sans Mono',
  \               },
  \   'ocean': { 'colorscheme': 'OceanicNext',
  \              'background': 'dark',
  \              'font-size': '14',
  \              'linespace': '3',
  \              'typeface': 'Droid Sans Mono',
  \               },
  \   'gruv':  { 'colorscheme': 'gruvbox-material',
  \              'lightline': 'gruvbox_material',
  \              'background': 'dark',
  \              'font-size': '14',
  \              'linespace': '3',
  \              'typeface': 'Droid Sans Mono',
  \               },
  \   'oned':  { 'colorscheme': 'onedark',
  \              'lightline': 'onedark',
  \              'background': 'dark',
  \              'font-size': '14',
  \              'linespace': '3',
  \              'typeface': 'Droid Sans Mono',
  \               },
  \ }

let cscheme = "gruv"

" set contrast
" this configuration option should be placed before `colorscheme gruvbox-material`
" available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'soft'

let g:lightline = {'colorscheme' : g:vimrc#themes[cscheme]["lightline"]}
call vimrc#set_theme(cscheme)

