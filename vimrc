set nocompatible

syntax on
filetype plugin indent on

function! InitPlugins()
    " iplug add remove vim-table*
    iplug add -q 
                \ https://github.com/ctrlpvim/ctrlp.vim 
                \ https://github.com/junegunn/goyo.vim
                \ https://github.com/reedes/vim-wordy
                \ https://github.com/tpope/vim-commentary
                \ https://github.com/junegunn/vim-peekaboo
                \ https://github.com/justinmk/vim-sneak
                \ https://github.com/reedes/vim-pencil
                \ https://github.com/reedes/vim-textobj-sentence
                \ https://github.com/reedes/vim-textobj-quote
                \ https://github.com/reedes/vim-lexical
                \ https://github.com/kana/vim-textobj-user
                \ https://github.com/rafi/awesome-vim-colorschemes
                \ https://github.com/lervag/vimtex
                \ https://github.com/tpope/vim-abolish
                \ https://github.com/jdelkins/vim-correction
                \ https://github.com/KeitaNakamura/tex-conceal.vim
                \ https://github.com/MattesGroeger/vim-bookmarks
                \ https://github.com/Konfekt/FastFold
                \ https://github.com/zhimsel/vim-stay
                \ https://github.com/d11wtq/ctrlp_bdelete.vim
                \ https://github.com/airblade/vim-rooter
                \ https://github.com/dhruvasagar/vim-table-mode 
                \ https://github.com/godlygeek/tabular
endfun


" Some basic options
set completeopt=noinsert,menuone,noselect
set history=500
set showcmd
set smartcase
set ignorecase
set showmatch
set incsearch
set nostartofline
set fileencoding=utf-8
set nowrap
set linebreak

" Show chars
set listchars=tab:↦·,trail:·
set list

set lazyredraw
set background=dark
set hidden
set conceallevel=2 concealcursor=
set splitright
set splitbelow
set path+=**
set fillchars+=vert:\│
set synmaxcol=5000
set expandtab

" Show full list and best match, then full
set wildmode=list:longest,full

" set exrc
" set secure

" Recommended for vim-stay
set sessionoptions-=cursor,folds,slash,unix

" No swap files, but undo files
set noswapfile
set nobackup
set nowritebackup
set undodir=~/backups
set undofile

" Some of my favourites
" colorscheme PaperColor
" colorscheme seoul
" colorscheme abstract
" colorscheme afterglow
" colorscheme scheakur
colorscheme one
set background=dark
ifont set Ios* --size 18

let mapleader=","
let maplocalleader=","

" Vimtex ------------------------------
let g:vimtex_compiler_enabled=0
set conceallevel=2

let g:vimtex_toc_config = { 'show_help' : 0, 'refresh_always' : 1, 'todo_sorted' : 0 }

" augroup vimtex
"   autocmd!
"   autocmd BufWritePost *.tex call vimtex#toc#refresh()
" augroup END

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

function! Prose()
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
  " nnoremap <buffer> <c-s> [s1z=<c-o>
  " inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

  " replace common punctuation
  " iabbrev <buffer> -- –
  " iabbrev <buffer> --- —
  " iabbrev <buffer> << «
  " iabbrev <buffer> >> »

  " open most folds
  setlocal foldlevel=6

  " replace typographical quotes (reedes/vim-textobj-quote)
  map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
  map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

  " highlight words (reedes/vim-wordy)
  " noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  " xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  " inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>
  "
  set conceallevel=2 concealcursor=i

endfunction "

" File Types ------------------
" automatically initialize buffer by file type
autocmd FileType markdown,mkd call Prose()

augroup tex
    autocmd!
    au FileType tex hi texItalStyle gui=italic guifg=pink
    " au FileType tex hi Conceal guibg=NONE gui=bold
    au FileType tex hi link Conceal PreProc 
    au FileType tex call Prose()
    au FileType tex setlocal conceallevel=2 concealcursor=
    au FileType tex setlocal foldmethod=expr
    au FileType tex setlocal foldexpr=vimtex#fold#level(v:lnum)
    au FileType tex setlocal foldtext=vimtex#fold#text()
augroup END


" invoke manually by command for other file types
command! -nargs=0 Prose call Prose()

" Mappings ------------------------------
"
let g:ctrlp_working_path_mode = 'ra'
map <leader>f :CtrlP<cr>
map <leader>F :CtrlPCurFile<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>m :CtrlPBookmark<cr>


" In insert or command mode, move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" Font sizes
nnoremap <c-0> :ifont +<cr>
nnoremap <c-9> :ifont -<cr>

let g:goyo_width = 80
let g:goyo_height = "100%"
nnoremap <c-8> :Goyo<cr>
nnoremap <c-1> :call SynGroup()<cr>

" I'm so used to doing this...
nmap <c-s> :w<cr>

" Rooter plugin
let g:rooter_cd_cmd = 'tcd'


" vim: fdm=marker sw=4 ts=4
