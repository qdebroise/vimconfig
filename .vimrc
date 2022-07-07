" Use these for navigation.
"
" @GENERAL  - General Vim configuration.
" @COLORS   - Colors & fonts.
" @FOLDING  - Folding related config.
" @MAPPINGS - Mappings.
" @UI       - User interface.
" @UX       - User experience.
" @NETRW    - Vim Netrw file explorer.
" @MISC     - Miscellaneous configurations.
" @PLUGINS  - Plugin related stuff
"       - cfilter: Vim built-in package.
"       - GDB: Vim built-in package.
"       - minicommenter: my own plugin :)
"       - auto-pairs: https://github.com/jiangmiao/auto-pairs
"       - FZF: https://github.com/junegunn/fzf
"       - Ripgrep (when available)


""""" @GENERAL {{{

" No compatibility mode
set nocp

" Set lines of history Vim has to remember.
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable file reloading if it has changed outside of Vim.
set autoread

" Remember info about open buffers on close.
set viminfo^=%

" Set the behavior when switching buffers like with the quickfix winwdow.
set switchbuf=useopen,usetab

" Use spaces instead of tabs.
set expandtab
" Set 1 Tab to be 4 spaces.
set shiftwidth=4
set tabstop=4

" Be smart when using tabs.
set smarttab

" Auto indentation & smart indentation
set ai
set si

" Wrap long lines.
set wrap

" Add a '$' when making changes to a line.
set cpoptions+=$

" Avoid getting stuck at search symbols when auto-completing (remove searching
" in include directories).
set complete-=i

" Auto-completion menu behavior configuration.
set completeopt=menu,longest,popup,noselect


"}}}

""""" @FOLDING {{{

" Enable folding.
set foldenable

" Fold according to C syntax.
" This gets *really* slow in large C files.
" set foldmethod=syntax
" set foldmethod=indent

" Allow one fold level only.
set foldnestmax=1

" Automatically closes folds when cursor not in them.
"set foldclose=all 


"}}}

""""" @MAPPINGS {{{

" Set Vim leader key.
let mapleader = ","
let g:mapleader = ","

" Fast saving mapping.
nmap <leader>w :up!<cr>

" Treat long lines as break lines.
map j gj
map k gk

" Disable search highlights with ',<CR>'.
map <silent> <leader><CR> :noh<CR>

" Better way to move between windows.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Better way to move out of a terminal window.
if has('terminal')
    tnoremap <C-j> <C-W>j
    tnoremap <C-k> <C-W>k
    tnoremap <C-h> <C-W>h
    tnoremap <C-l> <C-W>l
endif

" Remap Vim's '0' to first non-blank character.
map 0 ^

" Allow to use '.' in visual mode.
vnoremap . :norm.<CR>

" Quickly get out of insert mode.
inoremap jk <Esc>

" Indent in visual mode.
vnoremap < <gv
vnoremap > >gv

" Fast mapping to alternate between the two last opened buffers.
nnoremap <leader><Tab> <C-^>

" Easier jumping to matching bracket.
nnoremap <leader>ù %

" Change default tag jumping behavior to show the list of matching positions
" of the tag we try to jump to.
nnoremap <C-]> g<C-]>
nnoremap <C-$> g<C-]>

"" Completion

" Quick omni-completion.
inoremap <leader>; <C-x><C-o>

"" Quickfix

" Quickly open the quickfix window.
map <leader>q :topleft cope<CR>

" Jump to the next/previous item in quickfix list.
map <leader>n :cn<CR>
map <leader>p :cp<CR>

" Run make and open the quickfix window if any error.
map <F4> :make! -j6<CR><CR>:topleft cw 20<CR>

" Surround the visual selection with brackets, quotes, etc.
vnoremap $) <esc>`>a)<esc>`<i(<esc>
vnoremap $] <esc>`>a]<esc>`<i[<esc>
vnoremap $} <esc>`>a}<esc>`<i{<esc>
vnoremap $" <esc>`>a"<esc>`<i"<esc>
vnoremap $' <esc>`>a'<esc>`<i'<esc>

" Remap the :grep command so that:
" - No 'Press ENTER to continue' action is required.
" - Vim don't jump to the first match.
" - The quickfix window opens if there are any results.
cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() =~# '^grep')
    \ ? 'silent! grep! \| redr! \| topleft cw<C-Left><C-Left><C-Left><C-Left><C-Left><Left>'
    \ : 'grep'


"}}}

""""" @FILES {{{

" Set Vim path.
set path=.,**

" Files to ignore in the wild menu, vimgrep, etc.
set wildignore+=*~,*.o,*.d,*.pyc
set wildignore+=tags

" Set UTF-8 as standard encoding.
set encoding=utf8

" Use Unix as the standard file type.
set ffs=unix,dos,mac

" Disable backup files.
set nobackup
set nowb

" Disable swap files.
set noswapfile


"}}}

""""" @UI {{{

" Enable wild menu.
set wildmenu

set wildmode=list:longest,full

" Use a fuzzy finder to find completion matches and sort wildmenu entries by
" best-match.
if v:version >= 900
    set wildoptions=fuzzy
endif

" Always show cursor position.
set ruler

" Show the line the cursor is currently on.
set cursorline

" Height of the command bar.
set cmdheight=2

" Disable annoying stuff on errors.
set noerrorbells
set novisualbell

" Highlight the specified column.
set colorcolumn=100

" Display line numbers relative to the cursor position.
set relativenumber

" Paired with 'relativenumber', display the real line number the cursor is currently on.
set number

"  Use the minimum amount of space to display the numbers.
set numberwidth=1

"" Remove all the GUI garbage.
set guioptions-=m   " Remove menu bar
set guioptions-=T   " Remove toolbar
set guioptions-=r   " Remove right-hand scrollbar
set guioptions-=L   " Remove left-hand scrollbar
set guioptions-=e   " Remove tabs bar

" Disable tab line if there is only one tab.
set stal=1

" Always show the status line.
set laststatus=2

" Status line format.
set statusline=                                     " Clear the status line
set statusline+=[%n]                                " Buffer number.
set statusline+=\ %t                                " Filename.
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}]   " File encoding.
set statusline+=[%{&ff}]                            " File type.
set statusline+=%=                                  " Left/right separator.
set statusline+=Line:\ %l:%c                        " Cursor position.
set statusline+=\ \(%L\)                            " Total lines number.
set statusline+=\ \ \ %p%%\ \ \                     " Percentage through the file


"}}}

""""" @UX {{{

" Enable mouse scrolling.
set mouse=a

" Set an offset to the cursor when moving up/down.
set so=7

" Make buffer switching more convenient if buffers aren't saved.
set hid

" Configure backspace so that it acts as it should.
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching...
set ignorecase
" but be smart when using upper cases.
set smartcase

" Highlight search results.
set hlsearch

" Jump to search results while characters are being typed.
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Turn on special regex characters. See ':help magic' table.
set magic

" Highlight matching brackets.
set showmatch

" Blinking frequency when matching brackets.
set mat=2

" Include the cursor position in the selection.
set selection=inclusive

" When splitting put the new window right/below the current one.
set splitright
set splitbelow

"}}}

""""" @COLORS {{{

" Sets the number of colors to use.
set t_Co=256

" Enable syntax highlighting.
syntax enable

" Set dark background.
set background=dark

" Set colorscheme to use.
colorscheme aguamenti

" Change the default font on Windows GVim.
if has("win16") || has("win32")
    set guifont=Consolas:h10
endif

" Highlight markdown code blocks according to the language syntax.
let g:markdown_fenced_languages = ['c', 'cpp', 'c++=cpp', 'html', 'javascript', 'js=javascript', 'json=javascript', 'sh', 'bash=sh', 'xml']

"}}}

""""" @NETRW {{{

" Explorer shortcut
nnoremap <leader>e :Lexplore<CR><C-w>=

" Hide the explorer banner.
let g:netrw_banner=0

" Listing style format, 1 file per line.
let g:netrw_liststyle=1

let g:netrw_altv=1

" Human readable file sizes.
let g:netrw_sizestyle="H"

" Open file in previous window
let g:netrw_browse_split=4

" Make the explorer take 25% of screen space.
let g:netrw_winsize=25

" Explorer min width.
let g:netrw_wiw=25

" Browse faster by querying directory content only if it hasn't been seen before.
let g:netrw_fastbrowse=2


"}}}

""""" @MISC {{{

" Return to last edit position when opening files.
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Makes the cursor line only visible in the active window.
" Unfortunately, this is necessary otherwise the QuickFixLine and debugPC get
" overwritten by CursorLine in inactive windows.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Delete trailing whitespaces on save for C/C++ source files and headers.
autocmd BufWritePre *.[ch] %s/\s\+$//ge
autocmd BufWritePre *.cpp %s/\s\+$//ge
" Automatically add headguards for C header files.
autocmd BufNewFile *.h keepalt 0r ~/.vim/templates/skeleton.h | %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:VIM_EVAL:\]#\=eval(submatch(1))#ge
" Python template file.
autocmd BufNewFile *.py keepalt 0r ~/.vim/templates/skeleton.py
" GLSL filetype for syntax highlighting.
autocmd BufNewFile,BufRead *.vert,*.frag,*.glsl set ft=glsl

" Find to which highlight group a symbol belongs to.
map <F7> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>



"}}}

""""" @PLUGINS {{{

" Built-in plug-in to filter Quifix and Location lists.
silent! packadd cfilter

    """"" GDB {{{

    " Load GDB-Vim integration plugin (or fail silently)
    silent! packadd termdebug
    if exists(":Termdebug")
        " Open a debugging session.
        " Set the source file to the last file.
        " Go to the GDB window.
        nnoremap <leader><F5> :tabnew<CR>:Termdebug<CR><C-w>j<C-w>j<C-w>L:e#<CR>:Gdb<CR>file 

        " Automatically close the debugging tab (created with the previous
        " mapping) when quiting GDB.
        augroup EndDbgSession
            au!
            autocmd BufDelete !gdb silent! :tabclose
        augroup END
        
        " @TODO debugger mappings: step, over, break, delete, ...
    endif


    "}}}

    """"" minicommenter {{{
        noremap <leader>cc :ToggleComment<CR>


    "}}}

    """"" auto-pairs {{{


    "}}}

    """"" FZF {{{
        silent! packadd fzf
        if exists(":FZF")
            if has('popupwin')
                let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.4, 'relative': v:true, 'yoffset': 1.0 } }
            else
                let g:fzf_layout = { 'down': '40%' }
            endif
            " @Bug: collision with the ctrl-j/k binding for moving between buffers.
            " nnoremap <leader>f :FZF --bind=ctrl-j:down,ctrl-k:up<Enter>
            nnoremap <leader>f :FZF<Enter>
        endif

    "}}}

    """"" Ripgrep {{{
        " This isn't a VIM plugin per say but if the ripgrep executable is
        " found in $PATH then we can add custom bindings and make other
        " tools like FZF use ripgrep.
        if executable('rg')
            " Use ripgrep as the FZF file finder.
            let $FZF_DEFAULT_COMMAND='rg --files . 2> nul'
            let &grepprg='rg --vimgrep --smart-case'
        endif

    "}}}


"}}}

"" vim:foldmethod=marker
"" vim:foldclose=all
