" CoC:
"---------------------------------------------------------------------------
  
"---------------------------------------------------------------------------
" Functions:
"---------------------------------------------------------------------------

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  function! s:install_coc_ext()
    " Install
    if exists(':CocInstall')
      " Built In
      CocInstall 
        \ coc-json
        \ coc-yaml
        \ coc-python
        \ coc-snippets
        \ coc-html
        \ coc-css

      " Custom
      CocInstall
        \ https://github.com/arubertoson/vscode-snippets
    endif 
  endfunction


  command! -nargs=0 PlugCocInstall call <SID>install_coc_ext() 

"---------------------------------------------------------------------------
" Mapping:
"---------------------------------------------------------------------------

  " Use <tab> to confirm completion, and space to trigger
  inoremap <silent><expr> <c-space> coc#refresh()
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Goto
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gy <Plug>(coc-type-definition)
  " <Plug>(coc-definition)
  " <Plug>(coc-declaration)
  " <Plug>(coc-implementation)
  " <Plug>(coc-type-definition)
  " <Plug>(coc-references)


  " Other
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  nmap <leader>rn <Plug>(coc-rename)
