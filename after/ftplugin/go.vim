setlocal noexpandtab
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal tabstop=8

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
