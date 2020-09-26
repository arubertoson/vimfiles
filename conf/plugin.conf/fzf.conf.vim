
"
" Fzf:
"---------------------------------------------------------------------------

  if !executable('fzf')
    finish
  endif

"---------------------------------------------------------------------------

  let $FZF_DEFAULT_COMMAND='fd --hidden --type file -E ".git*" -E "__pycache__*"'
  let $FZF_DEFAULT_OPTS='--layout=reverse'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  let g:fzf_buffers_jump = 1
  let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }
  " let g:fzf_tags_command = 'retag'

  " Required configurations for drop down terminas
  aug user:autocmd:fzf
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer> <nowait> <esc> <c-c>

    " au User FzfStatusLine call statusline#fzf#()
    au BufLeave *FZF q!
    au FileType fzf set signcolumn=no
  aug END

"---------------------------------------------------------------------------
" Commands:
"---------------------------------------------------------------------------

  command! FZFMru call fzf#run(fzf#wrap('MRU', { 'source': MRUfiles() }))

  command! -bang -nargs=* RgDev
    \ call fzf#vim#grep('
      \ rg --column --line-number --no-heading --fixed-strings --no-ignore 
      \ --hidden --follow --smart-case --color=always
      \ -g "*.{js,json,php,md,styl,jade,html,config,py,h,hpp,cpp,c,go,hs,rb,conf,zsh,sh}"
      \ -g "!{.git,node_modules,vendor}/*"
    \ '.shellescape(<q-args>), 1,
    \ <bang>0 ? fzf#vim#with_preview('up:60%')
    \         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \ <bang>0)

  command! -bang -nargs=* RgAll
    \ call fzf#vim#grep('
      \ rg --column --line-number --no-heading --fixed-strings --no-ignore 
      \ --hidden --follow --smart-case --color=always
      \ -g "!{.git,node_modules,vendor}/*"
    \ '.shellescape(<q-args>), 1,
    \ <bang>0 ? fzf#vim#with_preview('up:60%')
    \         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \ <bang>0)

"---------------------------------------------------------------------------
" Functions:
"---------------------------------------------------------------------------

  function! MRUfiles()
    let l:ignore = 'fugitive:\|NERD_tree\|^/tmp/\|.git/\|term:'
    let l:files = extend(
          \ filter(copy(v:oldfiles), { _, f -> f !~ l:ignore }),
          \ map(filter(range(1, bufnr('$')), { _, f -> buflisted(f) }), { _, f -> bufname(f) }))
    let l:pwd = getcwd()
    return filter(copy(l:files), { _, f -> f =~ l:pwd })
  endfunction


  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)

    let height = float2nr(&lines * 0.4)
    let width = float2nr(&columns * 0.8)
    let horizontal = float2nr((&columns - width) / 2)
    let vertical = 0.5

    let opts = {
          \ 'relative': 'editor',
          \ 'row': vertical,
          \ 'col': horizontal,
          \ 'width': width,
          \ 'height': height
          \ }

    call nvim_set_current_win(nvim_open_win(buf, v:true, opts))
  endfunction

"---------------------------------------------------------------------------
" Mapping:
"---------------------------------------------------------------------------
  " Coc
  nnoremap <silent> <localleader>d  :<C-u>CocFzfList diagnostics<CR>
  nnoremap <silent> <localleader>b  :<C-u>CocFzfList diagnostics --current-buf<CR>
  nnoremap <silent> <localleader>l  :<C-u>CocFzfList location<CR>
  nnoremap <silent> <leader>c  :<C-u>CocFzfList commands<CR>
  nnoremap <silent> <leader>o  :<C-u>CocFzfList outline<CR>
  nnoremap <silent> <leader>s  :<C-u>CocFzfList symbols<CR>
  nnoremap <silent> <leader>S  :<C-u>CocFzfList services<CR>
  nnoremap <silent> <leader>p  :<C-u>CocFzfListResume<CR>

  nnoremap <silent> <leader>e  :<C-u>CocFzfList extensions<CR>

  " File Jumping
  nnoremap <silent> <localleader>f :Files<CR>
  nnoremap <silent> <localleader>g :GFiles<CR>
  nnoremap <localleader>j :Buffers<CR>
  nnoremap <localleader>t :BTags<CR>
  nnoremap <localleader>T :Tags<CR>

  nnoremap <leader>oh :Helptags<CR>
  nnoremap <leader>sh :History<CR>
  nnoremap <leader>sm :FzfBookmarks<CR>

  " Searching
  nnoremap <leader>ss :BLines<CR>
  nnoremap <leader>sd :RgDev<CR>
  nnoremap <leader>sl :RgAll<CR>

  " Others
  nnoremap <leader>ft :Filetypes<CR>
  nnoremap <leader>fc :Colors<CR>
