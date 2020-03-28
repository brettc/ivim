" {{{ Load Plugins
set nocompatible

" Load up pathogen, using an alternative folder.
source ~/ivim/pathogen/autoload/pathogen.vim
execute pathogen#infect('~/ivim/{}')

syntax on
filetype plugin indent on

" }}}

" Don't bother with this stuff
set noswapfile
set nobackup
set nowritebackup

" {{{ Display
colorscheme PaperColor
ifont 5 18

" }}}

let mapleader=","
let maplocalleader=","

function! Prose() " {{{ 
  " call pencil#init()
  call pencil#init({'wrap': 'soft'})
  call lexical#init()
  " call litecorrect#init()
  call textobj#quote#init()
  call textobj#sentence#init()

  " manual reformatting shortcuts
  nnoremap <buffer> <silent> Q gqap
  xnoremap <buffer> <silent> Q gq
  nnoremap <buffer> <silent> <leader>Q vapJgqap

  " force top correction on most recent misspelling
  nnoremap <buffer> <c-s> [s1z=<c-o>
  inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

  " replace common punctuation
  " iabbrev <buffer> -- –
  " iabbrev <buffer> --- —
  " iabbrev <buffer> << «
  " iabbrev <buffer> >> »

  " open most folds
  " setlocal foldlevel=6

  " replace typographical quotes (reedes/vim-textobj-quote)
  map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
  map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

  " highlight words (reedes/vim-wordy)
  " noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  " xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  " inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>

endfunction " }}}
" {{{ File Types

" automatically initialize buffer by file type
autocmd FileType markdown,mkd,text,tex call Prose()

" }}}

" invoke manually by command for other file types
command! -nargs=0 Prose call Prose()

" {{{ Mappings
let g:ctrlp_working_path_mode = 'ra'
map <leader>f :CtrlP<cr>
map <leader>F :CtrlPCurFile<cr>
map <leader>b :CtrlPBuffer<cr>

" I'm so used to doing this...
map <c-s> :w<cr>
" }}}

" vim: fdm=marker
