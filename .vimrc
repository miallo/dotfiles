set nocompatible

let s:path = expand('~/dotfiles')
set shell=/bin/bash

exec "set rtp+=" . s:path . "/.vim/bundle/Vundle.vim"
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
Plugin 'wincent/loupe'              " nice search
Plugin 'wincent/terminus'           " terminal setup
Plugin 'farmergreg/vim-lastplace'   " open last buffers
Plugin 'LnL7/vim-nix'               " nix syntax
Plugin 'tpope/vim-fugitive'         " git integration
Plugin 'airblade/vim-gitgutter'     " git marks in buffers
Plugin 'tpope/vim-eunuch'           " commandline tools
Plugin 'tpope/vim-surround'         " surround text-objects with quotes/parantheses
Plugin 'junegunn/fzf.vim'           " fuzzy file finder
Plugin 'ap/vim-css-color'           " show hex colours
"Plugin 'pangloss/vim-javascript' # disabled in favour of vim-jsx-improve
Plugin 'chemzqm/vim-jsx-improve'    " javascript syntax
Plugin 'vim-test/vim-test'          " integrate test suits
Plugin 'liuchengxu/vim-which-key'   " show which <leader>-maps are mapped
Plugin 'Yggdroot/indentLine'        " show indentation levels
Plugin 'dense-analysis/ale'         " linter and language server
"Plugin 'Shougo/deoplete.nvim'
Plugin 'tpope/vim-commentary'       " (un)comment lines
Plugin 'vimwiki/vimwiki'            " connected markdown files
Plugin 'chriskempson/base16-vim'    " color maps
Plugin 'darfink/vim-plist'          " (binary) plist support

call vundle#end()

let g:notermguicolors=1

exec "source " . s:path . "/nixos/neovim/init.vim"
