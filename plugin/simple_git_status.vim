if exists('g:loaded_git_files') | finish | endif
let g:loaded_git_files = 1

if !exists('g:git_files_setup_done')
  lua require("simple_git_status").setup()
  let g:git_files_setup_done = 1
endif

