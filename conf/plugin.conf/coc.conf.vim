
"
"   Repo URL: https://github.com/arubertoson/vimfiles
"   Author: Marcus Albertsson
"
"---------------------------------------------------------------------------
" CoC:
"---------------------------------------------------------------------------

if exists('+pumheight')
  set pumheight=30
endif

set noshowmode 
set statusline^=%{coc#status()}
set completeopt=noinsert,menuone,noselect

let g:coc_global_extensions = [
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-stylelint',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-pairs',
  \ 'coc-highlight',
  \ 'coc-yank',
  \ 'coc-git',
  \ 'coc-lists',
  \ 'coc-post',
  \ 'coc-marketplace',
  \ 'coc-explorer',
  \ 'coc-spell-checker',
  \ 'coc-cspell-dicts',
  \ 'coc-snippets',
  \ 'coc-diagnostics',
  \ 'coc-clangd',
  \ 'coc-actions',
  \ 'coc-vimlsp',
  \ 'coc-python',
  \ 'coc-smartf',
  \ 'coc-bookmark',
  \ 'coc-clangd',
  \ ]


"---------------------------------------------------------------------------
" CocTrigger: setup tab to trigger coc completion
"---------------------------------------------------------------------------

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

  inoremap <silent><expr> <C-Space> coc#refresh()

"---------------------------------------------------------------------------
" CocActions: actions to take on buffer
"---------------------------------------------------------------------------

  " Show Documentation
  nnoremap <silent> K :call CocActionAsync("doHover")<CR>

  " Rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " git hun
  nmap [g <Plug>(coc-git-prevhunk)
  nmap ]g <Plug>(coc-git-nexthunk)
  nmap gs <Plug>(coc-git-chunkinfo)

  " gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definitions)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Remap for do codeAction of selected region
  function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type . ' ' 
          \ . g:cocActionsTmpPos[1] . ' ' . g:cocActionsTmpPos[2]
  endfunction

  " press <esc> to cancel.
  nmap f <Plug>(coc-smartf-forward)
  nmap F <Plug>(coc-smartf-backward)

  " coc-explorer
  noremap <silent> <leader>e :execute 'CocCommand explorer' .
        \ ' --toggle' .
        \ ' --sources=file+'<CR>

  function! s:select_current_word()
    if !get(g:, 'coc_cursors_activated', 0)
      return "\<Plug>(coc-cursors-word)"
    endif
    return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
  endfunc

  " multiple cursors
  nmap <silent> <C-c> <Plug>(coc-cursors-position)
  nmap <expr> <silent> D <SID>select_current_word()
  xmap <silent> <C-d> <Plug>(coc-cursors-range)

  " use normal command like `<leader>xi(`
  nmap <leader>x  <Plug>(coc-cursors-operator)


"---------------------------------------------------------------------------
" Mapping:
"--------------------------------------------------------------------------

 " Using CocList
nnoremap <silent> <leader>ll :<C-u>CocList<CR>
" Show all diagnostics
nnoremap <silent> <leader>la  :<C-u>CocList diagnostics<cr>
" Show all buffers
nnoremap <silent> <leader>lb  :<C-u>CocList buffers<cr>
" Manage extensions
nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
" Open yank list
nnoremap <silent> <leader>ly  :<C-u>CocList -A --normal yank<cr>
" Open translators list with the current word
nnoremap <silent> <leader>lt  :<C-u>CocList --input=<C-r>=expand('<cword>')<cr> --interactive translators<cr>
" git status files
nnoremap <silent> <leader>lg  :<C-u>CocList --normal --auto-preview gstatus<CR>
" git commands
nnoremap <silent> <leader>cg  :<C-u>CocList --input=git. --normal commands<CR>
" flutter commands
nnoremap <silent> <leader>cf  :<C-u>CocList --input=flutter. --normal commands<CR>
" Resume latest coc list
nnoremap <silent> <leader><leader>  :<C-u>CocListResume<CR>

augroup coc_au
  autocmd!

  autocmd ColorScheme * call s:init()

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#ffbf67
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup END


inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function s:init() abort
  " do not underline error/info/hit lines
  highlight! NoCocUnderline cterm=None gui=None

  highlight! link HighlightedyankRegion Cursor

  " highlight! link CocHighlightText htmlLink XXX Needs to light up properly
  highlight! CocHighlightText cterm=underline gui=underline

  highlight! link CocErrorSign Error
  highlight! link CocWarningSign WarningMsg
  highlight! link CocInfoSign MoreMsg
  highlight! link CocHintSign ModeMsg

  highlight! link CocCodeLens ModeMsg

  highlight! link GitAddHi SignifySignAdd
  highlight! link GitModifyHi SignifySignChange
  highlight! link GitDeleteHi SignifySignDelete

  highlight! link CocCursorRange Cursor
endfunction
