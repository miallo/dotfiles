{ pkgs, ... }:

let
  vim-latex = pkgs.vimUtils.buildVimPlugin {
    name = "vim-latex";
    src = pkgs.fetchFromGitHub {
      owner = "vim-latex";
      repo = "vim-latex";
      rev = "d97bbf333453b793ab0916265c900299934723e2";
      sha256 = "1hzcsfq2zb091v4yy1jr10pi1yc3max1jlj8k5rr0gxvsy0rxzkw";
    };
  };
  vim-jsx-pretty = pkgs.vimUtils.buildVimPlugin {
    name = "vim-jsx-pretty";
    src = pkgs.fetchFromGitHub {
      owner = "maxmellon";
      repo = "vim-jsx-pretty";
      rev = "3a24dca8f8cc9b88efca3faf446db41f5b7da121";
      sha256 = "0gn9rlwndq0awv51gxvd3gsxlh5sb76cvc60bh0lsh4f4lhmyy3r";
    };
  };
  loupe = pkgs.vimUtils.buildVimPlugin {
    name = "loupe";
    src = pkgs.fetchFromGitHub {
      owner = "wincent";
      repo = "loupe";
      rev = "fdbfee0cffe094f0aa7e9039760633380fdb55f8";
      sha256 = "1mam21z6gbzfsx764mjcdbkbm7043jb8mpph9q7n3f32w351igjs";
    };
    meta = {
      description = "Make search/regex work bit more sensible";
    };
  };
  terminus = pkgs.vimUtils.buildVimPlugin {
    name = "terminus";
    src = pkgs.fetchFromGitHub {
      owner = "wincent";
      repo = "terminus";
      rev = "51c9bf43427af5ddff7352707a2bdab58cac9593";
      sha256 = "158adcq4hfv80qpkqdz555dqs45ahjnkggdzliqygpa8m9qjzmiq";
    };
    meta = {
      description = "Improve Terminal support: Cursor-Shape in insert, mouse support, focus reporting, bracketed paste";
    };
  };

in {
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    (neovim.override {
    #(vim_configurable.override {
      vimAlias = true;
      withPython3 = true;
      #python = python3;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
            vim-lastplace
            vim-nix
            vim-fugitive    # Git wrapper
            fzf
            loupe           # Search magically
            terminus        # Make terminal vim behave a bit more graphical
            #YouCompleteMe
            #ctrlp.vim'
            vim-latex
            vim-css-color
            vim-javascript
            #vim-js-file-import
            vim-jsx-pretty
            ale             # Linting
            base16-vim      # Colors
            nerdtree        # Filefinder
            #vim-gutentags
            vim-fireplace   # Clojure
            vim-commentary
          ];
          opt = [];
        };
        customRC = ''
          " your custom vimrc
          " VIM searches throu all sub-directories recursively for filenames
          set path+=**
          " Nice menu when typing `:find *.py`
          set wildmenu
          
          syntax on
          if has('syntax')
            set synmaxcol=200                   " don't bother syntax highlighting long lines
          endif
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
          
          set bs=indent,eol,start               " allow backspacing over everything in insert mode
          set ai                                " always set autoindenting on
          if exists('$SUDO_USER')
            set nobackup                        " don't create root-owned files
            set nowritebackup                   " don't create root-owned files
          else
            set backupdir=~/.vim/tmp/backup     " keep backup files out of the way
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
              set noundofile                    " don't create root-owned files
            else
              set undodir=~/.vim/tmp/undo       " keep undo files out of the way
              set undodir+=.
              set undofile                      " actually use undo files
            endif
          endif
          set updatecount=80                    " update swapfiles every 80 typed chars
          set updatetime=2000                   " CursorHold interval

          set viminfo='120,\"150                " read/write a .viminfo file, don't store more
                                                " than 150 lines of registers
          set history=50                        " keep 50 lines of command line history
          set ruler                             " show the cursor position all the time
          if has('mksession')
            set viewdir=~/.vim/tmp/view         " override ~/.vim/view default
            set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
          endif
          set hlsearch
          set spelllang=de,en
          syntax on

          " oberhalb und unterhalb der aktuellen Zeile immer 7 Zeilen platz
          " Um die Zeile auf dem Bildschirm zu zentrieren: zz
          set scrolloff=7
          set sidescrolloff=3

          "Insert single character in Normal-Mode and return back to normal-mode
          nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
          nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

          " <LocalLeader>s -- Fix (most) syntax highlighting problems in current buffer
          " (mnemonic: syntax).
          nnoremap <silent> <LocalLeader>s :syntax sync fromstart<CR>
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

          "Zeilen Nummerierung
          " toggle via :set nu! rnu!
          set number
          if exists('+relativenumber')
            set relativenumber
          endif
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

          set hidden
          if has('linebreak')
            set linebreak
          endif
          set nojoinspaces

          " Use mappings from terminal in command mode to move to beginning / end of line
          cnoremap <C-a> <Home>
          cnoremap <C-e> <End>

          " `<Tab>`/`<S-Tab>` to move between matches without leaving incremental search.
          " Note dependency on `'wildcharm'` being set to `<C-z>` in order for this to
          " work.
          set wildcharm=<C-z>
          cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
          cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'
          
          set tabstop=4
          set shiftwidth=4
          set expandtab
          set smarttab
          set pastetoggle=<F3>
          
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
          " set nofoldenable
          
          
          " let g:ycm_autoclose_preview_window_after_completion=1
          let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py']
          "set omnifunc=syntaxcomplete#Complete
          let g:ycm_path_to_python_interpreter = 'python'
          let g:ycm_python_binary_path = 'python3'
          
          let g:WincentColorColumnBlacklist = ['diff', 'undotree', 'nerdtree', 'qf']

          "Close vim if NERDtree is only Buffer left
          autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

          "JS-files fix eslint format on save
          let g:ale_fixers = {
           \ 'javascript': ['prettier', 'eslint'],
           \ 'latex': ['latexindent', 'textlint']
           \ }
           let g:ale_fix_on_save = 1

          "vim-js-file-import key bindings
          nnoremap <Leader>if <Plug>(JsFileImport)
          nnoremap <Leader>iF <Plug>(JsFileImportList)
          nnoremap <Leader>ig <Plug>(JsGotoDefinition)
          nnoremap <Leader>iG <Plug>(JsGotoDefinition)
          nnoremap <Leader>ip <Plug>(PromptJsFileImport)
          nnoremap <Leader>is <Plug>(SortJsFileImport)
          nnoremap <Leader>ic <Plug>(JsFixImport)
          
          
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
          set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
          set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
          if has('patch-7.4.314')
            set shortmess+=c                    " completion messages
          endif
          set shortmess+=o                      " overwrite file-written messages
          set shortmess+=t                      " truncate file messages at start
          
          "set background=dark
          set background=light


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

              if filereadable(expand('${vimPlugins.base16-vim}/share/vim-plugins/base16-vim/colors/base16-' . s:config[0] . '.vim'))
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

          set encoding=utf-8

          set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
        '';
      };
    })
  ];
}
