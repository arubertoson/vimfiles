
"---------------------------------------------------------------------------
" Global Commands:
"---------------------------------------------------------------------------

  command! -nargs=1 Indent execute
    \ 'setlocal tabstop='.<q-args>
    \ 'softtabstop='.<q-args>
    \ 'shiftwidth='.<q-args>
  command! -nargs=0 -bar GoldenRatio exe 'vertical resize' &columns * 5 / 8
  " Shows the syntax stack under the cursor
  command! -bar SS echo 
    \ map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  " Set color theme
  command! -nargs=? SetColorScheme call vimrc#set_theme(<q-args>)

"--------------------------------------------------------------------------
" Encoding Commands: {{{
"--------------------------------------------------------------------------

  " Open in UTF-8
  command! -nargs=? -bar -bang -complete=file EUtf8
      \ edit<bang> ++enc=utf-8 <args>
  
  " Open in CP1251
  command! -nargs=? -bar -bang -complete=file ECp1251
      \ edit<bang> ++enc=cp1251 <args>
  
  " Write as Unix
  command! -nargs=? -bar -bang -complete=file WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
  
  " Write as Dos
  command! -nargs=? -bar -bang -complete=file WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>
" }}}
