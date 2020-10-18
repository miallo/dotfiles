" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:
set winaltkeys=no
set spell
syntax off
syntax on


" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
"let g:Tex_ViewRule_pdf='open -a Preview.app'
let g:Tex_ViewRule_pdf='evince'
"let g:Tex_TreatMacViewerAsUNIX=0
let g:Tex_Env_enumerate="\\begin{enumerate}\<CR>\\item \<CR>\\end{enumerate}\<CR><++>"
let g:Tex_Env_figure="\\begin{figure}[htb]\<CR>\\centering\<CR>\\includegraphics[width=<++>\\linewidth]{<++>}\<CR>\\caption{<++>}\<CR>\\label{fig:<++>}\<CR>\\end{figure}\<CR><++>"
let g:Tex_Env_frame="\\begin{frame}\<CR>\\frametitle{<++>}\<CR>\\framesubtitle{<++>}\<CR><++>\<CR>\\end{frame}\<CR><++>"
let g:Tex_Env_section="\\section{<++>}\<CR><++>"
let g:Tex_Env_subsection="\\subsection{<++>}\<CR><++>"
let g:Tex_Env_subsubsection="\\subsubsection{<++>}\<CR><++>"
let g:Tex_Env_align="\\begin{align}\<CR><++> \\label{eq:<++>}\<CR>\\end{align}\<CR><++>"
"let g:Tex_Env_align*="\\begin{align*}\<CR><++> \\label{eq:<++>}\<CR>\\end{align*}\<CR><++>"
let g:Tex_Env_itemize="\\begin{itemize}\<CR>\\item <++>\<CR>\\end{itemize}\<CR><++>"
let g:Tex_Env_subfigure="\\begin{figure}[h]\<CR>\\centering\<CR>\\subfigure[<+Beschriftung 1+>\\label{fig:<+label1+>}]{\\includegraphics[width=0.49\\textwidth]{<+grafik1+>}}\<CR>\\hfill\<CR>\\subfigure[<+Beschriftung 2+>\\label{fig:<+label2+>}]{\\includegraphics[width=0.49\\textwidth]{<+grafik2+>}}\<CR>\\caption{<+Beschriftung allgemein+>\\label{fig:<+label-gesamt+>}}\<CR>\\end{figure}\<CR><++>"
let g:Tex_Env_table="\\begin{table}[h]\<CR>\\centering\<CR>\\begin{tabular}{|<++>|}\<CR><++>\<CR>\\end{tabular}\<CR>\\caption{<++>\\label{tab:<++>}}\<CR>\\end{table}\<CR><++>"
let g:Tex_Env_tabular="\\begin{table}[h]\<CR>\\centering\<CR>\\begin{tabular}{|<++>|}\<CR><++>\<CR>\\end{tabular}\<CR>\\caption{<++>\\label{tab:<++>}}\<CR>\\end{table}\<CR><++>"
let g:Tex_PromptedEnvironments="equation,equation*,align,align*,figure,subfigure,itemize,enumerate,table,frame"
"let g:Tex_FoldedSections=""
let g:Tex_FoldedMisc="preamble,<<<"
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode -synctex=1 --src-specials -shell-escape $*'
let g:Tex_GotoError=0

"let g:Tex_IgnoredWarnings.="\n"."has changed"."\n"."Unused global option(s): [pagesize]"."\n"."There were undefined citations"
"let g:Tex_IgnoreLevel+=3

