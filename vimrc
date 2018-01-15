" Minimalisitc Vim configuration file for my dev environment
" Author : Nilangshu Bidyanta [nb0dy]
set nocp
execute pathogen#infect()
syntax enable
filetype plugin indent on

set modelines=5
set autoindent smartindent
set tabstop=8
set shiftwidth=8
set smarttab
set ruler

function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=80
  endif
endfunction

nnoremap <silent> <F2> :call g:ToggleColorColumn()<CR>

autocmd BufNewFile,BufRead *.c set formatprg=astyle\ -A8\ -t8\ -k3\ -p\ -H\ -xC80\ -xL
autocmd BufNewFile,BufRead *.cpp set formatprg=astyle\ -A8\ -t8\ -k1\ -p\ -H\ -xC120\ -xL
autocmd FileType make setlocal noexpandtab
autocmd FileType cpp setlocal expandtab tabstop=2 shiftwidth=2 colorcolumn=120

set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch

map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-k> <C-W>k
map <C-l> <C-W>l

set fdm=syntax
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_by_filename = 1

set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme solarized

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the following symbols for tabstops, trailing spaces and EOLs
set listchars=tab:▸\ ,eol:¬,trail:░

let g:autotagTagsFile="tags"
let g:autotagStopAt="$HOME/prj"
set laststatus=2
let g:syntastic_cpp_compiler_options = '-std=c++17'
let g:syntastic_cpp_compiler = 'g++-7'
