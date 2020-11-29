let g:mapleader = "\<Space>"
let g:maplocalleader = ','


set encoding=utf-8

set title                   " show current buffername in title of terminal


"############################## Finding Stuff ##############################"
" VIM searches throu all sub-directories recursively for filenames
set path+=**
" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" " `<Tab>`/`<S-Tab>` to move between matches without leaving incremental search.
" " Note dependency on `'wildcharm'` being set to `<C-z>` in order for this to
" " work.
" set wildcharm=<C-z>
" cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
" cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Yank into system clipboard
set clipboard=unnamedplus

syntax on
" <LocalLeader>s -- Fix (most) syntax highlighting problems in current buffer
" (mnemonic: syntax).
nnoremap <silent> <LocalLeader>s :syntax sync fromstart<CR>
" if has('syntax')
"   set synmaxcol=200                   " don't bother syntax highlighting long lines
" endif
filetype plugin indent on

set backspace=indent,eol,start          " backspace deletes more than current insert in insert mode
set autoindent                          " When creating a new line => indentation from previous line is taken

" Files for temporary vim-files
if exists('$SUDO_USER')
    set nobackup                        " don't create root-owned files
    set nowritebackup                   " don't create root-owned files
else
    set backupdir=~/.vim/tmp/backup//   " keep backup files out of the way
    set backupdir+=.
endif
if exists('$SUDO_USER')
    set noswapfile                      " don't create root-owned files
else
    set directory=~/.vim/tmp/swap//     " keep swap files out of the way
    set directory+=.
endif
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile                  " don't create root-owned files
    else
        set undodir=~/.vim/tmp/undo//   " keep undo files out of the way
        set undodir+=.
        set undofile                    " actually use undo files
    endif
endif
set updatecount=80                      " update swapfiles every 80 typed chars
set updatetime=2000                     " CursorHold interval

set shada=!,'100,<50,s10,h,%            " save variables, registers,... from last session
set history=50                          " keep 50 lines of command line history
set ruler                               " show the cursor position all the time
if has('mksession')
    set viewdir=~/.vim/tmp/view//       " override ~/.vim/view default
    set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
endif
set hlsearch
set spelllang=de,en

" oberhalb und unterhalb der aktuellen Zeile immer 7 Zeilen platz
" Um die Zeile auf dem Bildschirm zu zentrieren: zz
set scrolloff=7
set sidescrolloff=3

" Split in a more natural way
set splitright splitbelow

"Insert single character and return back to normal-mode
nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" Toggle fold at current position.
nnoremap <Tab> za
if has('folding')
    if has('windows')
        set fillchars=diff:∙               " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
        set fillchars+=fold:·              " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
        set fillchars+=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    endif

    if has('nvim-0.3.1')
        set fillchars+=eob:\              " suppress ~ at EndOfBuffer
    endif
endif

" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>
" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$
" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

set whichwrap=b,<,>,[,],~       " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries

" Line numbering
" toggle via :set nu! rnu!
set number
" if exists('+relativenumber')
"     set relativenumber
" endif
" " automatically switch between relative and non-relative numbers when entering
" "     insert mode
" augroup numbertoggle
"     autocmd!
"     autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"     autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END


" some keycombinations exit insert mode
inoremap jj <esc>
inoremap jk <esc>
inoremap kj <esc>

set hidden                          " Allow buffers to be in the background without writing them
if has('linebreak')
    set linebreak                   " Break lines at spaces instead of last character
endif
set nojoinspaces                    " When joining lines, make only single space after . ! ?

" Use mappings from terminal in command mode to move to beginning / end of line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

set tabstop=4                       " A <Tab> is shown as 4 spaces
set shiftwidth=4                    " autoindent will increment in 4 spaces
set expandtab                       " insert spaces instead of <Tab>
set smarttab                        " delete groups of spaces as if they were tabs

" If terminal does not support sutomatic insert detection. Not neded if
" |bracketed-paste-mode|
set pastetoggle=<F3>

" simple movements between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" sort lines alphabetically
vnoremap <Leader>s :sort<CR>

" indentation via < > without exiting visual
vnoremap < <gv
vnoremap > >gv



augroup python
    au!
    au FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    au FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    au FileType python nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
    au FileType python imap <buffer> <c-c> #################################################################
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
    au FileType tex nmap  <LocalLeader>l   :call ListTrans_toggle_format()<CR>
    au FileType tex xmap  <LocalLeader>l   :call ListTrans_toggle_format('visual')<CR>
    au FileType tex call Tex_MakeMap('<leader>ll', ':update!<CR>:call Tex_RunLaTeX()<CR>', 'n', '<buffer>')
    au FileType tex call Tex_MakeMap('<leader>ll', '<ESC>:update!<CR>:call Tex_RunLaTeX()<CR>', 'v', '<buffer>')
augroup END

set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
" + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)

set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo [w]/[written] when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
if has('patch-7.4.314')
    set shortmess+=c                    " completion messages
endif
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start

"set background=dark
set background=light


"################################# Plugins  ################################"
"" Deoplete: code completion
let g:deoplete#enable_at_startup = 1
"Add extra filetypes
let g:deoplete#sources#ale#filetypes = [
            \ 'jsx',
            \ 'javascript.jsx',
            \ 'vue',
            \ 'javascript'
            \ ]
let g:deoplete#custom#sources#ale#rank = 999
"autocmd VimEnter * call deoplete#custom#source('ale', 'rank', 999)
"call deoplete#custom#option('sources', {
"  \ '_': ['ale'],
"\})
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"" ALE: run prettier and linter
if exists("g:deoplete#enable_at_startup")
    let g:ale_completion_enabled = g:deoplete#enable_at_startup ? 0 : 1
else
    let g:ale_completion_enabled = 1
endif
let g:ale_completion_autoimport = 1
"JS-files fix eslint format on save
let g:ale_fixers = {
            \ 'javascript': ['prettier', 'eslint'],
            \ 'latex': ['latexindent', 'textlint']
            \ }
let g:ale_fix_on_save = 1

"" vim-test: run tests from vim
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" ultisnips: create snipets
let g:UltiSnipsSnippetsDir = expand("~/.vim/UltiSnips")
let g:UltiSnipsSnippetDirectories= [ UltiSnipsSnippetsDir ]
if !isdirectory(UltiSnipsSnippetsDir)
    exec "!git clone git@github.com:miallo/ultisnips-snippets.git ".expand(UltiSnipsSnippetsDir)
endif

" FZF to find files fuzzily from Sebastian
" let FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
" " Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
" command! -bang -nargs=* Rg
"             \ call fzf#vim#grep(
"             \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"             \   <bang>0 ? fzf#vim#with_preview('up:60%')
"             \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"             \   <bang>0)

" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" command! -bang -nargs=? -complete=dir Files
"             \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '${pkgs.vimPlugins.fzf-vim}/bin/preview.sh {}']}, <bang>0)

" Command-T: fuzzy file finder
" use git for finding files => accepts .gitignore. If no git repo => use find
let g:CommandTFileScanner='git'

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
" set nofoldenable

" vimwiki: Edit markdown wiki
let g:vimwiki_list = [
            \{
            \ 'auto_export': 1,
            \ 'auto_header' : 1,
            \ 'automatic_nested_syntaxes':1,
            \ 'path_html': '$HOME/wiki/html',
            \ 'path': '$HOME/wiki/src',
            \ 'template_path': '$HOME/wiki/templates/',
            \ 'template_default':'GitHub',
            \ 'template_ext':'.html5',
            \ 'syntax': 'markdown',
            \ 'ext':'.md',
            \ 'custom_wiki2html': '$HOME/.vim/scripts/wiki2html.sh',
            \ 'auto_tags': 1,
            \ 'list_margin': 0,
            \ 'links_space_char' : '_',
            \},
            \]
" let g:vimwiki_folding='expr'
let g:vimwiki_hl_headers = 1
" let g:vimwiki_ext2syntax = {'.md': 'markdown'}
"augroup vimwiki
"  au!
"  au FileType vimwiki nnoremap  <Leader>wl <Plug>VimwikiVSplitLink
"augroup END

" indentLine: show indentations
let g:indentLine_fileTypeExclude=['tex', 'help']
let g:indentLine_bufNameExclude=['NERD_tree.*']


"Close vim if NERDtree is only Buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"vim-js-file-import key bindings
"nnoremap <Leader>if <Plug>(JsFileImport)
"nnoremap <Leader>iF <Plug>(JsFileImportList)
"nnoremap <Leader>ig <Plug>(JsGotoDefinition)
"nnoremap <Leader>iG <Plug>(JsGotoDefinition)
"nnoremap <Leader>ip <Plug>(PromptJsFileImport)
"nnoremap <Leader>is <Plug>(SortJsFileImport)
"nnoremap <Leader>ic <Plug>(JsFixImport)

" vim-which-key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" " auto-pairs
" let g:AutoPairsShortcutToggle = '<M-Shift-p>'
" let g:AutoPairsShortcutFastWrap = '<M-Shift-e>'
" let g:AutoPairsShortcutJump = '<M-Shift-n>'
" let g:AutoPairsShortcutJump = '<M-Shift-n>'

" loupe
let g:LoupeCenterResults=0            " If searchresult is on screen => don't center it
let g:LoupeVeryMagicReplace=1         " remove verymagic \v when leaving search empty in replace
" change word under cursor and navigate to next instance with n, repeat with .
nnoremap c* *Ncgn

let g:WincentColorColumnBlacklist = ['diff', 'undotree', 'nerdtree', 'qf']
if has('autocmd')
    if exists('+colorcolumn')
        autocmd BufEnter,FocusGained,VimEnter,WinEnter * if index(g:WincentColorColumnBlacklist, &filetype) == -1 | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
        autocmd FocusLost,WinLeave * if index(g:WincentColorColumnBlacklist, &filetype) == -1 | let &l:colorcolumn=join(range(1, 255), ',') | endif
    endif
endif

function s:CheckColorScheme()
    if !has('termguicolors')
        let g:base16colorspace=256
    else
        set termguicolors
    endif

    let s:config_file = expand('~/.vim/.base16')

    if filereadable(s:config_file)
        let s:config = readfile(s:config_file, "", 2)

        if s:config[1] =~# '^dark\|light$'
            execute 'set background=' . s:config[1]
        else
            echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
        endif

        if filereadable(expand('~/.vim/base16-vim/colors/base16-' . s:config[0] . '.vim'))
            execute 'color base16-' . s:config[0]
        else
            echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
        endif
    else " default
        set background=dark
        color base16-default-dark
    endif

    "execute 'highlight Comment ' . pinnacle#italicize('Comment')
    execute 'highlight link EndOfBuffer ColorColumn'

    " Allow for overrides:
    " - `statusline.vim` will re-set User1, User2 etc.
    " - `after/plugin/loupe.vim` will override Search.
    doautocmd ColorScheme
endfunction
if v:progname !=# 'vi'
    if has('autocmd')
        augroup WincentAutocolor
            autocmd!
            autocmd FocusGained * call s:CheckColorScheme()
        augroup END
    endif

    call s:CheckColorScheme()
endif

" Fugitive: git integration
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
