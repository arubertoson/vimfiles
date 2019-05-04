"
" Fzf:
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" Commands:
"---------------------------------------------------------------------------

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \ <bang>0 ? fzf#vim#with_preview('up:60%')
    \         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \ <bang>0)


"---------------------------------------------------------------------------
" Mapping:
"---------------------------------------------------------------------------

  " File Jumping
  nnoremap <leader>of :Files<CR>
  nnoremap <leader>og :GFiles<CR>
  nnoremap <leader>ob :Buffers<CR>
  nnoremap <leader>oh :Helptags<CR>
  nnoremap <leader>ot :BTags<CR>

  " Tags
  nnoremap <leader>sh :History<CR>
  nnoremap <leader>sm :FzfBookmarks<CR>
  nnoremap <leader>st :Tags<CR>

  " Searching
  nnoremap <leader>ss :BLines<CR>
  nnoremap <leader>sl :Lines<CR>
  nnoremap <leader>sr :Rg<CR>

  " Others
  nnoremap <leader>ft :Filetypes<CR>
  nnoremap <leader>fc :Colors<CR>
