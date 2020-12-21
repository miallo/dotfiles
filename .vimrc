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
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'ehamberg/vim-cute-python'
Plugin 'vim-latex/vim-latex'
Plugin 'wincent/loupe'
Plugin 'wincent/terminus'
Plugin 'farmergreg/vim-lastplace'
Plugin 'LnL7/vim-nix'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf.vim'
Plugin 'ap/vim-css-color'
"Plugin 'pangloss/vim-javascript' # disabled in favour of vim-jsx-improve
Plugin 'chemzqm/vim-jsx-improve'
Plugin 'vim-test/vim-test'
Plugin 'liuchengxu/vim-which-key'
Plugin 'Yggdroot/indentLine'
Plugin 'dense-analysis/ale'
"Plugin 'Shougo/deoplete.nvim'
Plugin 'tpope/vim-commentary'
Plugin 'vimwiki/vimwiki'
Plugin 'chriskempson/base16-vim'
Plugin 'darfink/vim-plist'

call vundle#end()

let g:notermguicolors=1

source ~/dotfiles/nixos/neovim/init.vim
