

  let mywiki = {}
  let mywiki.path = '/scratch/dev/gitlab.com/arubertoson/vimwiki/home'    
  let mywiki.syntax = 'markdown'
  let mywiki.ext = '.md'

  let workwiki = {}
  let workwiki.path = '/scratch/dev/gitlab.com/arubertoson/vimwiki/work'
  let workwiki.syntax = 'markdown'
  let workwiki.ext = '.md'



  let g:vimwiki_list = [mywiki, workwiki]
  let g:vimwiki_ext2syntax = {
    \ '.md': 'markdown',
    \ '.markdown': 'markdown',
    \ }
