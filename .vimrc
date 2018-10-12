" .vimrc - Brad McDuffie (c)2013
" Notes and more!
" " are the comment character; comments are cool
" I never can remember how to: delete blank lines: :g/^$/d

" Pathogen is a way to manage all of your vim plugins
" https://github.com/tpope/vim-pathogen
" Use this to get all of the goodness.
call pathogen#infect()
syntax on
filetype plugin indent on

" NERDTree is cool.  Get it.
" cd ~/.vim/bundle
" git clone git://github.com/scrooloose/nerdtree.git
"
if filereadable(".NERDTreeBookmarks")
	let NERDTreeBookmarksFile=".NERDTreeBookmarks"
endif
let PHP_outdentphpescape=0
let g:NERDTreeDirArrows=0
let g:NERDTreeWinPos = "left"

" Enable pathogen for easy plugin handling
runtime! autoload/pathogen.vim
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

" This 'fixes' vim to do typeover like vi did.
set cpo=aABceFs$

set t_ti= t_te= t_vb=
set tabstop=2

" sets my colorscheme
colorscheme elflord
set pastetoggle=<F2>
set background=dark

set swapfile
set dir=~/.vim/swp

" coming home to vim recommendations
"set nocompatible
set modelines=0
set shiftwidth=2
set softtabstop=2
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set undofile
set undodir=~/.vim-undo//
set backupskip=/tmp/*,/private/tmp/*"
let mapleader=","
"noremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap<leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
set wrap
set textwidth=72
set formatoptions=qrn1
"set colorcolumn=+1

" cleans up all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" cleans up all leading whitespace
nnoremap <leader>b :%s/^\s\+//<cr>:let @/=''<CR>
" 'fold tag' function???
nnoremap <leader>ft Vatzf
" sort css properties ?
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" format paragraphs
nnoremap <leader>q gqip
" Underline line
nnoremap <leader>Q yypVr-
" reselect the just pasted text
nnoremap <leader>v V`]
" quickly open vimrc in a window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" quickly escape out of insert mode with jj
inoremap jj <ESC>
" windowing
" open a vertical split
noremap <leader>w <C-w>v<C-w>l
" moving between split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Toggle "keep current line in the center of the screen" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>
"set mouse=a
"set mousefocus
" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>
nnoremap <leader>l :setlocal relativenumber!<cr>
nnoremap <leader>g :GitBlame<cr>
nnoremap <leader>T :Tabular block<cr>
map <M-Esc>[62~ <ScrollWheelUp>                                       
map! <M-Esc>[62~ <ScrollWheelUp>                                      
map <M-Esc>[63~ <ScrollWheelDown>                                     
map! <M-Esc>[63~ <ScrollWheelDown>                                    
map <M-Esc>[64~ <S-ScrollWheelUp>                                     
map! <M-Esc>[64~ <S-ScrollWheelUp>                                    
map <M-Esc>[65~ <S-ScrollWheelDown>                                   
map! <M-Esc>[65~ <S-ScrollWheelDown>     

map <leader>t :NERDTreeToggle<CR>
"map <leader>r :ToggleRainbowParenthesis<CR>
map <leader>r :RainbowParenthesesToggle<CR>

augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

"au BufNewFile,BufRead *.php set filetype=php
au BufRead,BufNewFile *.pp
  \ set filetype=ruby

au BufRead,BufNewFile *.ino
  \ set filetype=cpp

au BufRead,BufNewFile *.go
  \ setlocal number

abbreviate teh the
abbreviate adn and

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

augroup yml
    au!
    au BufNewFile,BufRead *.yml,*.yaml setlocal filetype=yaml shiftwidth=2 softtabstop=2 tabstop=2
augroup END
    
    
" Set swp files to specific dir
set swapfile
set dir=~/.vim/swp

" sets my cursorline to be a gray background
set cursorline
hi cursorline ctermbg=236 cterm=none
" just some color notes
"89 is a dark pink
"236 is a nice gray

hi StatusLine     term=bold,reverse cterm=bold,reverse ctermfg=130 ctermbg=15 gui=bold,reverse guifg=#262626 guibg=fg

hi MatchParen cterm=reverse ctermfg=lightblue

if has("autocmd")
  " When editing a file, always jump to the last known cursor position. 
  " Don't do it when the position is invalid or when inside an event handler 
  " (happens when dropping a file on gvim). 
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")


let g:go_fmt_command = "goimports"
