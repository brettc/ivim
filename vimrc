set nocompatible
syntax off

" Load up pathogen
source ~/ivim/pathogen/autoload/pathogen.vim
execute pathogen#infect('~/ivim/{}')

syntax on
filetype plugin indent on

" Display
"colorscheme wombat
ifont 5 18

let mapleader=","
let maplocalleader=","

" Mapping
nmap j gj
nmap k gk
set linebreak

"map <leader>b :CtrlPBuffer<cr>
