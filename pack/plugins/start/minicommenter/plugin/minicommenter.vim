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

" If the selection is greater than the parameter then block commenting will be
" used if available.
call s:var_init_missing("g:mincomment_block_threshold", 50)

" Filetypes comments symbols {{{
" This list if based on the list in the NERDCommenter plugin.
" https://github.com/preservim/nerdcommenter
"
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

function s:toggle_comment() range
    " Print a nice message to the the user when filetype is unknown.
    if !b:mincomment_filetype_known
        echohl WarningMsg |
            \ echom 
                \   "Unkown comment symbols for '" . &filetype . "' filetype. "
                \ . "Extend the list in ~/.vim/pack/plugins/start/minicommenter/plugin/minicommenter.vim :)" | 
            \ echohl None
        return
    endif

    " Find which types of comment are available.
    let single_comment_available = !empty(b:mincomment_sym[0])
    let block_comment_available = !empty(b:mincomment_sym[1])

    if !single_comment_available && !block_comment_available
        echohl WarningMsg |
            \ echom 
                \   "No commenting symbols defined for '" . &filetype . "' filetype. "
                \ . "Update the symbols for this filetype in ~/.vim/pack/plugins/start/minicommenter/plugin/minicommenter.vim :)" | 
            \ echohl None
        return
    endif

    " Retrieve comment symbols.
    if single_comment_available
        let single = b:mincomment_sym[0][0]
    endif
    if block_comment_available
        let block_beg = b:mincomment_sym[1][0]
        let block_end = b:mincomment_sym[1][1]
    endif

    let range = a:lastline - a:firstline + 1

    let start = reltime()
    if (single_comment_available && range < g:mincomment_block_threshold) ||
      \(range >= g:mincomment_block_threshold && !block_comment_available)
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

            let is_commented = l[indent:indent+len(single)-1] ==# single
            if is_commented
                " @TODO(performance): compare with other solutions.
                call setline(current_line, substitute(l, '\(^\s*\)'. single .' \?', '\1', ''))
                " call setline(current_line, repeat(' ', indent) . l[indent+len(single)+1:])
            else
                " @TODO(performance): compare with other solution.
                call setline(current_line, substitute(l, '\(^\s*\)', '\1'. single .' ', ''))
                " call setline(current_line, repeat(' ', indent) . '// ' . l[indent:])
            endif

            let current_line += 1
        endwhile
    elseif block_comment_available
        " Block commenting.
        call append(a:lastline, block_end)
        call append(a:firstline - 1, block_beg)
    endif
    echom (a:lastline - a:firstline + 1) . " lines commented in " . reltimestr(reltime(start)) . " s"

endfunction


"}}}


noremap <leader>cc :call <sid>toggle_comment()<cr>


"" vim:foldmethod=marker
"" vim:foldclose=all
