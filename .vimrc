set nocompatible

let s:path = expand('~/dotfiles')
set shell=/bin/bash

exec "set rtp+=" . s:path . "/.vim/bundle/Vundle.vim"
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" Plugin 'Valloric/YouCompleteMe'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'ehamberg/vim-cute-python'
" Plugin 'shougo/deoplete.nvim'
" Plugin 'thoughtstream/Damian-Conway-s-Vim-Setup'
Plugin 'LnL7/vim-nix'               " nix syntax
Plugin 'SirVer/ultisnips'
Plugin 'Yggdroot/indentLine'        " show indentation levels
Plugin 'airblade/vim-gitgutter'     " git marks in buffers
Plugin 'airblade/vim-rooter'        " set root of vim to project folder
Plugin 'ap/vim-css-color'           " show hex colours
Plugin 'chemzqm/vim-jsx-improve'    " javascript syntax
Plugin 'chriskempson/base16-vim'    " color maps
Plugin 'darfink/vim-plist'          " (binary) plist support
Plugin 'dense-analysis/ale'         " linter and language server
Plugin 'editorconfig/editorconfig-vim'
Plugin 'farmergreg/vim-lastplace'   " open last buffers
Plugin 'junegunn/fzf.vim'           " fuzzy file finder
Plugin 'liuchengxu/vim-which-key'   " show which <leader>-maps are mapped
Plugin 'miallo/loupe'               " nice search
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-commentary'       " (un)comment lines
Plugin 'tpope/vim-eunuch'           " commandline tools
Plugin 'tpope/vim-fugitive'         " git integration
Plugin 'tpope/vim-rsi'              " some emacs keybindings
Plugin 'tpope/vim-surround'         " surround text-objects with quotes/parantheses
Plugin 'vim-latex/vim-latex'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-test/vim-test'          " integrate test suits
Plugin 'vimwiki/vimwiki'            " connected markdown files
" Plugin 'wincent/command-t'          " fuzzy file finder
Plugin 'nvim-lua/popup.nvim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'wincent/terminus'           " terminal setup

call vundle#end()

let g:notermguicolors=1

exec "source " . s:path . "/nixos/neovim/init.vim"
