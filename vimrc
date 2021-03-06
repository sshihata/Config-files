syntax enable              "syntax highlighting
set number		             "line numbering
filetype plugin on         "file type detection and loading plugins for specific types
filetype indent on	       "enable indentation based on file type
set shellslash	     	     "handle forward slashes in file names
set grepprg=grep\ -nH\ $*  "set grep program
set exrc 		               "source vimrc if present in directory
set secure 		             "restrict usage of commands if not default vimrc
set fillchars+=vert:\      "remove bar character in vertical split 
set smartindent 
set shiftwidth=2
set tabstop=2
set expandtab
set tw=80                  "80 chars per line
set formatoptions+=t
set wrap
let mapleader=","

" keymap
nmap <c-t> :terminal<CR>
tnoremap <Esc><Esc> <C-\><C-n>


execute pathogen#infect()  

colorscheme xoria256

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'

" Syntastic options

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:LatexBox_latexmk_options = "-pvc -pdfps"
