"
"
"

function! mdpreview#open() abort

  if exists('s:markdown_job_id') && s:markdown_job_id > 0
    call jobstop(s:markdown_job_id)
    unlet s:markdown_job_id
  endif

  let s:markdown_job_id = jobstart(
    \ 'grip ' . shellescape(expand('%:p')) . " 0 2>&1 | awk '/Running/ { printf $4 }'",
    \ { 'pty': 1, 'on_stdout': {_, output -> system('xdg-open ' . output[0])} }
    \ )

endfunction
