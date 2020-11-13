set nocompatible
set shell=/bin/bash

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'thoughtstream/Damian-Conway-s-Vim-Setup'
" Auto-Completion
Plugin 'Valloric/YouCompleteMe'
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'ehamberg/vim-cute-python'
Plugin 'vim-latex/vim-latex'
Plugin 'darfink/vim-plist'
Plugin 'psf/black'

call vundle#end()


" VIM searches throu all sub-directories recursively for filenames
set path+=**
" Nice menu when typing `:find *.py`
set wildmenu




syntax on
filetype plugin indent on



" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on



set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='120,\"150	" read/write a .viminfo file, don't store more
			" than 150 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set hlsearch
set spelllang=de,en
syntax on

" oberhalb und unterhalb der aktuellen Zeile immer 7 Zeilen platz
" Um die Zeile auf dem Bildschirm zu zentrieren: zz
set scrolloff=7

"Insert single character in Normal-Mode and return back to normal-mode
nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

"Zeilen nummerierung
" toggle via :set nu! rnu!
set number relativenumber
" automatically switch between relative and non-relative numbers when entering
"     insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"k auf visual k
nnoremap <Up> gk
"j auf visual j
nnoremap <Down> gj
"jj auf esc 
inoremap jj <esc>
inoremap jk <esc>
inoremap kj <esc>
inoremap jJ <esc>

set tabstop=4
set shiftwidth=4
set expandtab
set pastetoggle=<F3>

augroup plistfinal
    au!
    autocmd BufWriteCmd,FileWriteCmd .ffuserdata call plist#Write()
    autocmd BufReadCmd .ffuserdata call plist#Read(1) | call plist#ReadPost()
    autocmd FileReadCmd .ffuserdata call plist#Read(0) | call plist#SetFiletype()
augroup END

augroup python
	au!
	au FileType python map <buffer> <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
    autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    au FileType python nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
	au FileType python imap <buffer> <c-c> ###################################################################
    "au FileType python imap <silent> <buffer> . .<C-X><C-O>
augroup END

augroup latex
	au!
	"F12 als make Prohaupt.pdf
	au FileType tex imap <buffer> <C-B> <Plug>Tex_MathBF
	au FileType tex imap <buffer> <C-I> <Plug>Tex_InsertItemOnThisLine
	au FileType tex imap <buffer> <F12> <esc>:w<CR>:!pdflatex -shell-escape %<CR><CR>
	au FileType tex imap <buffer> <c-c> <++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
	au FileType tex map <buffer> <F12> :w<CR>:!pdflatex -shell-escape %<CR><CR>
    "toggle between lists and comma separated text
    au FileType tex nmap  ;l   :call ListTrans_toggle_format()<CR>
    au FileType tex xmap  ;l   :call ListTrans_toggle_format('visual')<CR>
    au FileType tex call Tex_MakeMap('<leader>ll', ':update!<CR>:call Tex_RunLaTeX()<CR>', 'n', '<buffer>')
    au FileType tex call Tex_MakeMap('<leader>ll', '<ESC>:update!<CR>:call Tex_RunLaTeX()<CR>', 'v', '<buffer>')
augroup END

map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

"sort lines alphabetically (Leader is \ by default)
vnoremap <Leader>s :sort<CR>

" indentation via < > without exiting visual
vnoremap < <gv
vnoremap > >gv

noremap <buffer> <C-n> :nohl<CR>
vnoremap <buffer> <C-n> :nohl<CR>

" ctrlp stuff
"let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable


" let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py']
"set omnifunc=syntaxcomplete#Complete
let g:ycm_path_to_python_interpreter = 'python'
let g:ycm_python_binary_path = 'python3'


set guicursor=

"set background=dark
set background=light

set encoding=utf-8