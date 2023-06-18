set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
set clipboard=unnamedplus

set signcolumn=yes

set fileformat=unix
filetype plugin indent on
" for tabulation
set tabstop=4
" set softtabstop=4
set shiftwidth=2
set smartindent
set expandtab
set autoindent

set wrap

" Set shiftwidth for different file extensions
autocmd FileType typescript setlocal shiftwidth=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascriptreact setlocal shiftwidth=2
autocmd FileType typescriptreact setlocal shiftwidth=2
autocmd FileType json setlocal shiftwidth=4

" Set syntax highlight for .tsx and .jsx files
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

set background=dark

set t_Co=256
let mapleader = ' '

" autoremove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

inoremap jk <esc>

call plug#begin()

" lsp-servers
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" JS, TS, JSX, TSX
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

Plug 'vim-python/python-syntax'
Plug 'preservim/nerdtree'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'LunarWatcher/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'preservim/tagbar'

Plug 'lewis6991/gitsigns.nvim'

Plug 'tpope/vim-rhubarb'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.9.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" airline themes
Plug 'vim-airline/vim-airline-themes'

" color schemas
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'lunarvim/colorschemes'

call plug#end()

nnoremap <silent> U :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

let g:python_highlight_all=1

" Tailiwindcss
au FileType html let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']

" Comment .py files
nnoremap <C-k> :normal I# <Esc>
nnoremap <C-u> :silent! execute 'normal 0f#xx' \| :nohlsearch<CR>

vnoremap <silent> <C-k> :s/^/# /<cr>:noh<cr>
vnoremap <silent> <C-u> :s/^# //<cr>:noh<cr>

" gitsigns setup()
lua require('gitsigns').setup()

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" auto-pairs
let g:AutoPairs = autopairs#AutoPairsDefine([{ "open": "<", "close": "", "filetype": ["html"] }])
let g:AutoPairsMapBS = 1
let g:AutoPairsMultilineBackspace = 1
let g:auto_pairs_map_keys = 1

" cgn
nnoremap <silent> c<Tab> :let @/=expand('<cword>')<cr>cgn

" Telescope
nnoremap ,ff <cmd> Telescope find_files cwd=. hidden=true<cr>

" Markdown
nnoremap <c-s> <Esc>:MarkdownPreview<cr>

" Ctrl + a to select all text
map <C-a> <esc>ggVG<CR>

" "nm" to exit visual mode
xnoremap nm <Esc>

" Ctrl + c to copy text
vnoremap <C-c> "+y

" Backspace to remove selected text in visual mode
xnoremap <BS> "_d

" Move to next or previous file
map gn :bn<cr>
map gp :bp<cr>

" Shift + L keybindings in visual and normal modes
nnoremap <S-J> <C-D>
nnoremap <S-K> <C-U>
nnoremap <S-L> w
nnoremap <S-H> b

vnoremap <S-J> <C-D>
vnoremap <S-K> <C-U>
vnoremap <S-L> w
vnoremap <S-H> b

" colorscheme
colorscheme moonfly

if (has("termguicolors"))
    set termguicolors
endif

" airline
source $HOME/.config/nvim/themes/airline.vim

lua require 'colorizer'.setup()
" lua require('Comment').setup()

" NerdTree
let NERDTreeQuitOnOpen=1
nmap <Tab> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Refresh NERDTree buffer and focus on current project's folder
nnoremap nr :NERDTreeRefreshRoot<CR>:NERDTreeRefreshRoot<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Coc
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

" Tabs
nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>
" nmap <C-w> :bd<CR>
nmap cls :bd<CR>

" Deletion
nnoremap <Delete> "_d
nnoremap d "_d

vnoremap <Delete> "_d

" Unhighlight highlighted text
nnoremap ,<space> :nohlsearch<CR>

" Set termguicolors
hi DiagnosticError guifg=White
hi DiagnosticWarn  guifg=White
hi DiagnosticInfo  guifg=White
hi DiagnosticHint  guifg=White

lua << EOF
local plenary = require "plenary"
local status, treesitter = pcall(require, "nvim-treesitter.configs")

require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules', '__pycache__', 'static', 'htmlcov', 'migrations', 'media', '.coverage', '.git/' },
  },
}

require('telescope').load_extension('fzf')
EOF

