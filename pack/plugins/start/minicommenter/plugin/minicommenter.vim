" File: minicommenter.vim
" Description: minimalist commenting plugin.
" Maintainer: Quentin Debroise
" License: WTFPL (http://www.wtfpl.net/about)
"
" Note: A default, non-exhaustive, list of filetypes and comments symbols is
" available. This list can be extended by appending new lines to it.
" To extend this list jump to @FILETYPE_SYM_MAP.

""""" Init {{{

if v:version < 800
    echoerr "minicommenter plugin requires Vim >= 8"
    finish
endif

if exists("g:loaded_minicommenter")
    finish
else
    let g:loaded_minicommenter = 1
endif

" Initialize a variable to the given value if it doesn't exist.
function s:var_init_missing(var, value)
    if !exists(a:var)
        execute 'let ' . a:var . ' = ' . "'" . a:value . "'"
    endif
endfunction

" Always use block commenting when available.
call s:var_init_missing("g:mincomment_always_use_block", 0)

" Filetypes comments symbols {{{
" @FILETYPE_SYM_MAP
"
" format: 'filetype' : [['single line'], ['block begin', 'block end]]
let s:filetype_comment_symbols_map = {
    \ 'actionscript'           : [              ['//'],        ['/*', '*/']],
    \ 'ada'                    : [              ['--'],                  []],
    \ 'apache'                 : [               ['#'],                  []],
    \ 'asciidoc'               : [              ['//'],                  []],
    \ 'applescript'            : [              ['--'],        ['(*', '*)']],
    \ 'asm'                    : [               [';'],                  []],
    \ 'awk'                    : [               ['#'],                  []],
    \ 'basic'                  : [               ["'"],                  []],
    \ 'bc'                     : [               ['#'],                  []],
    \ 'bib'                    : [               ['%'],                  []],
    \ 'c'                      : [              ['//'],        ['/*', '*/']],
    \ 'clojure'                : [               [';'],                  []],
    \ 'cmake'                  : [               ['#'],                  []],
    \ 'coffee'                 : [               ['#'],                  []],
    \ 'cpp'                    : [              ['//'],        ['/*', '*/']],
    \ 'cuda'                   : [                  [],        ['/*', '*/']],
    \ 'crontab'                : [               ['#'],                  []],
    \ 'cs'                     : [              ['//'],        ['/*', '*/']],
    \ 'cterm'                  : [               ['*'],                  []],
    \ 'desktop'                : [               ['#'],                  []],
    \ 'dhcpd'                  : [               ['#'],                  []],
    \ 'diff'                   : [               ['#'],                  []],
    \ 'django'                 : [                  [],     ['<!--', '-->']],
    \ 'dns'                    : [               [';'],                  []],
    \ 'dosbatch'               : [            ['REM '],                  []],
    \ 'dosini'                 : [               [';'],                  []],
    \ 'dot'                    : [              ['//'],        ['/*', '*/']],
    \ 'elf'                    : [               ["'"],                  []],
    \ 'elmfilt'                : [               ['#'],                  []],
    \ 'erlang'                 : [               ['%'],                  []],
    \ 'fstab'                  : [               ['#'],                  []],
    \ 'gdb'                    : [               ['#'],                  []],
    \ 'gitcommit'              : [               ['#'],                  []],
    \ 'gitconfig'              : [               [';'],                  []],
    \ 'gitrebase'              : [               ['#'],                  []],
    \ 'glsl'                   : [              ['//'],        ['/*', '*/']],
    \ 'gnuplot'                : [               ['#'],                  []],
    \ 'go'                     : [              ['//'],        ['/*', '*/']],
    \ 'groovy'                 : [              ['//'],        ['/*', '*/']],
    \ 'haskell'                : [                  [],        ['{-', '-}']],
    \ 'haxe'                   : [              ['//'],        ['/*', '*/']],
    \ 'hostsaccess'            : [               ['#'],                  []],
    \ 'html'                   : [                  [],     ['<!--', '-->']],
    \ 'htmldjango'             : [                  [],     ['<!--', '-->']],
    \ 'inittab'                : [               ['#'],                  []],
    \ 'java'                   : [              ['//'],        ['/*', '*/']],
    \ 'javacc'                 : [              ['//'],        ['/*', '*/']],
    \ 'javascript'             : [              ['//'],        ['/*', '*/']],
    \ 'javascript.jquery'      : [              ['//'],        ['/*', '*/']],
    \ 'jsp'                    : [                  [],    ['<%--', '--%>']],
    \ 'less'                   : [                  [],        ['/*', '*/']],
    \ 'lisp'                   : [               [';'],        ['#|', '|#']],
    \ 'llvm'                   : [               [';'],                  []],
    \ 'lua'                    : [              ['--'],      ['--[[', ']]']],
    \ 'lynx'                   : [               ['#'],                  []],
    \ 'mail'                   : [              ['> '],                  []],
    \ 'make'                   : [               ['#'],                  []],
    \ 'man'                    : [              ['."'],                  []],
    \ 'maple'                  : [               ['#'],                  []],
    \ 'markdown'               : [                  [],     ['<!--', '-->']],
    \ 'masm'                   : [               [';'],                  []],
    \ 'mason'                  : [                  [],      ['<% #', '%>']],
    \ 'matlab'                 : [               ['%'],                  []],
    \ 'nasm'                   : [               [';'],                  []],
    \ 'nginx'                  : [               ['#'],                  []],
    \ 'ntp'                    : [               ['#'],                  []],
    \ 'objc'                   : [              ['//'],        ['/*', '*/']],
    \ 'objcpp'                 : [              ['//'],        ['/*', '*/']],
    \ 'ocaml'                  : [                  [],        ['(*', '*)']],
    \ 'octave'                 : [               ['%'],                  []],
    \ 'pascal'                 : [                  [],          ['{', '}']],
    \ 'pdf'                    : [               ['%'],                  []],
    \ 'perl'                   : [               ['#'],                  []],
    \ 'php'                    : [              ['//'],        ['/*', '*/']],
    \ 'plsql'                  : [             ['-- '],        ['/*', '*/']],
    \ 'prolog'                 : [               ['%'],        ['/*', '*/']],
    \ 'python'                 : [              ['# '],                  []],
    \ 'registry'               : [               [';'],                  []],
    \ 'resolv'                 : [               ['#'],                  []],
    \ 'rspec'                  : [               ['#'],                  []],
    \ 'ruby'                   : [               ['#'],                  []],
    \ 'samba'                  : [               [';'],                  []],
    \ 'sass'                   : [              ['//'],                  []],
    \ 'scala'                  : [              ['//'],        ['/*', '*/']],
    \ 'scons'                  : [               ['#'],                  []],
    \ 'scilab'                 : [              ['//'],                  []],
    \ 'sed'                    : [               ['#'],                  []],
    \ 'sh'                     : [               ['#'],                  []],
    \ 'sql'                    : [              ['--'],                  []],
    \ 'tags'                   : [               [';'],                  []],
    \ 'tcl'                    : [               ['#'],                  []],
    \ 'texinfo'                : [             ['@c '],                  []],
    \ 'tidy'                   : [               ['#'],                  []],
    \ 'tmux'                   : [               ['#'],                  []],
    \ 'twig'                   : [                  [],        ['{#', '#}']],
    \ 'vb'                     : [               ["'"],                  []],
    \ 'verilog'                : [              ['//'],        ['/*', '*/']],
    \ 'vhdl'                   : [              ['--'],                  []],
    \ 'vim'                    : [               ['"'],                  []],
    \ 'winbatch'               : [               [';'],                  []],
    \ 'xquery'                 : [                  [],        ['(:', ':)']],
\}

"}}}


"}}}

""""" Filetype detection {{{

augroup minicommenter
    autocmd BufEnter,BufRead * :call s:update_comment_symbols(&filetype)
    autocmd Filetype * :call s:update_comment_symbols(&filetype)
augroup END

function s:update_comment_symbols(filetype)
    let b:mincomment_filetype_known = has_key(s:filetype_comment_symbols_map, a:filetype)
    if b:mincomment_filetype_known
        let b:mincomment_sym = s:filetype_comment_symbols_map[a:filetype]
    endif

endfunction


"}}}

""""" Core {{{

function minicommenter#toggle_comment() range
    if !b:mincomment_filetype_known
        echohl WarningMsg |
            \ echom
                \   "Unkown comment symbols for '" . &filetype . "' filetype. "
                \ . "Extend the list in ~/.vim/pack/plugins/start/minicommenter/plugin/minicommenter.vim :)" |
            \ echohl None
        return
    endif

    let has_line_comment = len(b:mincomment_sym[0]) == 1
    let has_block_comment = len(b:mincomment_sym[1]) == 2

    if !has_line_comment && !has_block_comment
        echohl WarningMsg |
            \ echom 
                \   "No commenting symbols defined for '" . &filetype . "' filetype. "
                \ . "Update the symbols for this filetype in ~/.vim/pack/plugins/start/minicommenter/plugin/minicommenter.vim" | 
            \ echohl None
        return
    endif

    let use_block_comment = (has_block_comment && !has_line_comment) || (g:mincomment_always_use_block && has_block_comment)
    let sym_start = use_block_comment ? b:mincomment_sym[1][0] : b:mincomment_sym[0][0]
    let sym_end = use_block_comment ? b:mincomment_sym[1][1] : ''

    let start = reltime()

    " Per line commenting.
    let current_line = a:firstline
    while current_line <= a:lastline
        let l = getline(current_line)
        let indent = matchend(l, '^\s*')

        " Skip empty lines
        if empty(l) || indent == len(l)
            let current_line += 1
            continue
        endif

        let is_commented = l[indent:indent+len(sym_start)-1] ==# sym_start
        if is_commented
            call setline(current_line, use_block_comment
                \ ? repeat(' ', indent) . l[indent+len(sym_start)+1:-len(sym_end) - 2]
                \ : repeat(' ', indent) . l[indent+len(sym_start)+1:])
        else
            call setline(current_line, use_block_comment
                \ ? repeat(' ', indent) . sym_start . ' ' . l[indent:] . ' ' . sym_end
                \ : repeat(' ', indent) . sym_start . ' ' . l[indent:])
        endif

        let current_line += 1
    endwhile

    echom (a:lastline - a:firstline + 1) . " lines commented in " . reltimestr(reltime(start)) . " s"
endfunction


"}}}


command! -range -nargs=0 ToggleComment <line1>,<line2>call minicommenter#toggle_comment()


"" vim:foldmethod=marker
"" vim:foldclose=all
