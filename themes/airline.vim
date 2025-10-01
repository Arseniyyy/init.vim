" let g:airline_theme = 'base16_black_metal_gorgoroth'
let g:airline_theme = 'base16_onedark'
" let g:airline_theme='base16_cupcake'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemode = ':t'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
let g:airline_section_z = '%3p%%'
let g:airline#extensions#encoding#enabled = 0

" powerline symbols
let g:airline_symbols = {}
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

set showtabline=2

set noshowmode

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ }


