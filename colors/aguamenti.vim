"
" Description: Aguamenti colorscheme.
" Maintainer: Quentin Debroise.
" Categories:
"
" @GENERAL  - General colors like numbers and background.
" @VISUAL   - Visual mode colors.
" @SPELLING - Spell checker.
" @SYNTAX   - Language syntax.
" @FOLDS    - Anything related to Vim folds.
" @STATUS   - Status line.
" @COMMENT  - Comments.
" @LITERAL  - Programming language literals.
" @PMENU    - Auto-completion popup menu.
" @TABS     - Tabs & the tab line.
" @PROMPT   - Prompts like : yes/no question, more, ... 
" @CURSOR   - Cursor.
" @DIFFS    - Vimdiff.
" @SEARCH   - Search.
" @ERRORS   - Errors & warnings.
" @NONTEXT  - Non texts like vertical bars and stuff.
" @GDB      - GNU debugger.
" @OTHERS   - Non categorized things.
"
" XTerm colors reference:
"   - https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg


""""" Init {{{

set background=dark

" Reset all highlightings to the defaults.
hi clear

" Update syntax highlighting when enabled.
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "aguamenti"


" Colorizing helper function.
" Usage : `call s:colorize('HighlightGroup', ['ctermfg', 'ctermbg', 'cterm', 'guifg', 'guibg', 'gui'])`
function! s:colorize(group, params)
    if len(a:params) != 6
        echoerr "Aguamenti: colorize() expects an array of 6 parameters."
        return
    endif

    exec 'hi ' . a:group
        \ . ' ctermfg=' . (empty(a:params[0]) ? 'NONE' : a:params[0])
        \ . ' ctermbg=' . (empty(a:params[1]) ? 'NONE' : a:params[1])
        \ . ' cterm='   . (empty(a:params[2]) ? 'NONE' : a:params[2])
        \ . ' guifg='   . (empty(a:params[3]) ? 'NONE' : a:params[3])
        \ . ' guibg='   . (empty(a:params[4]) ? 'NONE' : a:params[4])
        \ . ' gui='     . (empty(a:params[5]) ? 'NONE' : a:params[5])
endfunction


"}}}


""""" @GENERAL {{{

call s:colorize('Normal'      , ['252', '232',     '', '#c8c8c8', '#181818',     '']) " General background and foreground.
call s:colorize('LineNr'      , ['243',    '',     '', '#767676',        '',     '']) " Numbers.
call s:colorize('CursorLineNr', ['243',    '',     '', '#767676',        '',     '']) " Number where the cursor currently is.
call s:colorize('Directory'   , ['68',     '', 'bold', '#5f87d7',        '', 'bold']) " Directories (eg in Netrw, edit file, etc).


"""}}}

""""" @VISUAL {{{

call s:colorize('Visual'   , ['', '24', '', '', '#005f87', '']) " Selection color in visual mode.
call s:colorize('VisualNOS', ['', '24', '', '', '#005f87', '']) " Color when selection is external to Vim.


"}}}

""""" @SPELLING {{{

" @Todo: I don't use these.

call s:colorize('SpellRare' , ['', '', '', '', '', ''])
call s:colorize('SpellBad'  , ['', '', '', '', '', ''])
call s:colorize('SpellCap'  , ['', '', '', '', '', ''])
call s:colorize('SpellLocal', ['', '', '', '', '', ''])


""""" }}}

""""" @SYNTAX {{{

call s:colorize('Statement'   , ['115', '',     '', '#87d7af', '',     '']) " C 'if', 'else', 'return', 'break', etc.
call s:colorize('Conditional' , ['115', '',     '', '#87d7af', '',     ''])
call s:colorize('Repeat'      , ['115', '',     '', '#87d7af', '',     '']) " C 'while', 'do', 'for', etc.
call s:colorize('Label'       , ['115', '',     '', '#87d7af', '',     '']) " C 'default', etc.
call s:colorize('Operator'    , [   '', '',     '',        '', '',     ''])
call s:colorize('Structure'   , ['110', '', 'bold', '#87afd7', '', 'bold']) " C 'struct', 'enum', etc.
call s:colorize('Typedef'     , ['110', '', 'bold', '#87afd7', '', 'bold']) " C 'typedef', etc.
call s:colorize('Type'        , ['110', '',     '', '#87afd7', '',     '']) " C 'int', 'float', etc.
call s:colorize('StorageClass', ['110', '',     '', '#87afd7', '',     '']) " C 'const', 'static', etc.
call s:colorize('Constant'    , ['132', '',     '', '#af5f87', '',     '']) " C 'true', 'false', 'NULL', etc.
call s:colorize('Function'    , [   '', '',     '',        '', '',     ''])
call s:colorize('Keyword'     , [   '', '',     '',        '', '',     ''])
" The following include all the C preprocessor directives 'define', 'include', 'if', etc.
call s:colorize('Macro'    , ['67', '', '', '#5f87af', '', ''])
call s:colorize('Define'   , ['67', '', '', '#5f87af', '', ''])
call s:colorize('Include'  , ['67', '', '', '#5f87af', '', ''])
call s:colorize('PreCondit', ['67', '', '', '#5f87af', '', ''])
call s:colorize('PreProc'  , ['67', '', '', '#5f87af', '', ''])

" C specifics.
call s:colorize('cOperator'   , ['215', '',     '', '#ffaf5f', '',     ''])

" Python specifics.
call s:colorize('pythonOperator',   ['115',     '',     '', '#87d7af',      '',     '']) " in, and, or, etc.
call s:colorize('pythonBuiltin' ,   ['110',     '',     '', '#87afd7',      '',     '']) " len, None, int, etc.
" call s:colorize('pythonBuiltin' ,   ['215',     '',     '', '#ffaf5f',      '',     ''])


"}}}

""""" @FOLDS {{{

call s:colorize('Folded'    , ['', '233', '', '', '#121212', ''])
call s:colorize('FoldColumn', ['', '233', '', '', '#121212', ''])


"}}}

""""" @STATUS {{{

" call s:colorize('StatusLine'  , ['217', '234', '', '#ffafaf', '#005f87', ''])
call s:colorize('StatusLine'  , [ '16',  '95', '', '#000000', '#875f5f', '']) " Status line in window with focus
call s:colorize('StatusLineNC', ['217', '234', '', '#ffafaf', '#1c1c1c', '']) " Status line in windows without focus


"}}}

""""" @COMMENT {{{

call s:colorize('Comment'       , ['242', '',               '', '#6c6c6c', '',               '']) " Comments color.
call s:colorize('SpecialComment', ['246', '',               '', '#949494', '',               '']) " Comments like documentation and stuff.
call s:colorize('Todo'          , ['208', '', 'bold,underline', '#ff8700', '', 'bold,underline']) " Todos.


"}}}

""""" @LITERAL {{{

call s:colorize('Identifier' , ['132', '', '', '#af5f87', '', ''])
call s:colorize('SpecialChar', ['210', '', '', '#ff8787', '', ''])
call s:colorize('Character'  , ['216', '', '', '#ffaf87', '', ''])
call s:colorize('String'     , ['132', '', '', '#af5f87', '', ''])
" call s:colorize('String'     , ['216', '', '', '#ffaf87', '', ''])
call s:colorize('Boolean'    , ['132', '', '', '#af5f87', '', ''])
call s:colorize('Number'     , ['132', '', '', '#af5f87', '', ''])
call s:colorize('Float'      , ['132', '', '', '#af5f87', '', ''])
call s:colorize('Float'      , ['132', '', '', '#af5f87', '', ''])

"}}}

""""" @PMENU {{{

call s:colorize('Pmenu'     , ['234', '225', '', '#1c1c1c', '#ffafff', '']) " Normal item colors.
call s:colorize('PmenuSel'  , [ '15',  '96', '', '#ffffff', '#d700d7', '']) " Selected item.
call s:colorize('PmenuThumb', [   '', '242', '',        '', '#585858', '']) " Scrollbar background.
call s:colorize('PmenuSbar' , [   '', '139', '',        '', '#ff5fff', '']) " Scrollbar thumb.


"}}}

""""" @TABS {{{

call s:colorize('TabLine'    , ['235',  '23', '', '#262626', '#005f5f', '']) " Unactive tabs.
call s:colorize('TabLineSel' , ['252',  '29', '', '#d0d0d0', '#00875f', '']) " Active tab.
call s:colorize('TabLineFill', [   '', '232', '',        '', '#080808', '']) " Tabs line where there are no labels.


"}}}

""""" @PROMPT {{{

call s:colorize('ModeMsg' , ['113', '', '', '#87d75f', '', '']) " Vim current mode (INSERT, VISUAL, etc).
call s:colorize('MoreMsg' , ['113', '', '', '#87d75f', '', '']) " More, message prompt.
call s:colorize('Question', ['113', '', '', '#87d75f', '', '']) " Yes/no questions prompt (like asking for substitutions).
call s:colorize('MoreMsg' , [   '', '', '',        '', '', '']) " '-- More --' prompt


"}}}

""""" @CURSOR {{{

call s:colorize('CursorLine'  , ['', '234', '', '', '#2a2933', '']) " Line the cursor is on. (set cursorline)
call s:colorize('CursorColumn', ['', '234', '', '', '#1c1c1c', '']) " Column the cursor is on. (set cursorcolumn)
call s:colorize('Cursor'      , ['',    '', '', '', '#ffffff', ''])
call s:colorize('iCursor'     , ['',    '', '', '', '#ffffff', ''])


"}}}

""""" @DIFFS {{{

" @Todo: fill when I'll find a need to use Vimdiff.

call s:colorize('DiffText'   , ['', '', '', '', '', ''])
call s:colorize('diffCommon' , ['', '', '', '', '', ''])
call s:colorize('DiffAdd'    , ['', '', '', '', '', ''])
call s:colorize('diffAdded'  , ['', '', '', '', '', ''])
call s:colorize('DiffDelete' , ['', '', '', '', '', ''])
call s:colorize('diffRemoved', ['', '', '', '', '', ''])
call s:colorize('DiffChange' , ['', '', '', '', '', ''])
call s:colorize('diffChanged', ['', '', '', '', '', ''])


"}}}

""""" @SEARCH {{{

call s:colorize('Search'      , [ '16', '215',        '', '#000000', '#ffaf5f',        '']) " Search results.
call s:colorize('MatchParen'  , ['232', '202', 'reverse', '#080808', '#ff5f00', 'reverse']) " Paired parenthesis highlight.
call s:colorize('IncSearch'   , [ '16', '215',        '', '#000000', '#ffaf5f',        '']) " Incremental search.
call s:colorize('WildMenu'    , [ '16', '215',        '', '#000000', '#ffaf5f',        '']) " Match in WildMenu completion.
call s:colorize('QuickFixLine', [ '16',  '37',        '', '#000000', '#00afaf',        '']) " Selected item in the quickfix list.


"}}}

""""" @ERRORS {{{

call s:colorize('ErrorMsg'  , ['197', '', '', '#ff005f', '', '']) " Error message on the command line.
call s:colorize('WarningMsg', ['227', '', '', '#ffff5f', '', '']) " Warning messages.
call s:colorize('Error'     , [   '', '', '',        '', '', ''])


"}}}

""""" @NONTEXT {{{

call s:colorize('NonText'    , ['243',    '', '', '#767676',        '', '']) " Characters that don't really exists.
call s:colorize('ColorColumn', [   '', '233', '',        '', '#121212', '']) " Color column color.
call s:colorize('VertSplit'  , ['243',    '', '', '#767676',        '', '']) " Vertical split.


"}}}

""""" @GDB {{{

call s:colorize('debugPC'        , ['0',  '27', '', '#000000', '#005fff', '']) " Next line being executed.
call s:colorize('debugBreakpoint', [ '', '196', '',        '', '#ff0000', '']) " Breakpoint.
call s:colorize('SignColumn'     , [ '', '233', '',        '', '#121212', '']) " Breakpoints column.


"}}}

""""" @OTHER {{{

call s:colorize('Special'   , ['132', '', '', '#af5f87', '', ''])
call s:colorize('Title'     , ['202', '', '', '#ff5f00', '', '']) " Tab title.

call s:colorize('Tag'       , [   '', '', '', '',        '', ''])
call s:colorize('Delimiter' , [   '', '', '', '',        '', ''])
call s:colorize('Debug'     , [   '', '', '', '',        '', ''])
call s:colorize('Exception' , [   '', '', '', '',        '', ''])
call s:colorize('SpecialKey', [   '', '', '', '',        '', ''])


"}}}

"" vim:foldmethod=marker
"" vim:foldclose=all
