set mouse=a
set encoding=utf-8
set number
"set number relativenumber
syntax enable
set scrolloff=7
set backspace=indent,eol,start

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set clipboard=unnamedplus
set termencoding=utf-8

set t_Co=256

filetype indent on

set wrap
set linebreak

set nobackup
set noswapfile


"let mapleader = "\<C>"
let mapleader = ' '

let python_highlight_all=1

" autoremove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

inoremap jk <esc>

call plug#begin()

Plug 'numToStr/Comment.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'bmatcuk/stylelint-lsp'
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rhubarb'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'honza/vim-snippets'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.9.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" airline themes
Plug 'vim-airline/vim-airline-themes'

" color schemas
Plug 'morhetz/gruvbox'  " colorscheme gruvbox
Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'
Plug 'lunarvim/colorschemes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

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

" Telescope
nnoremap ,ff <cmd> Telescope find_files cwd=. hidden=true<cr>

" Markdown
nnoremap <c-s> <Esc>:MarkdownPreview<cr>

" Signify
let g:signify_sign_add = '+'
let g:signify_sign_delete = '_'
"let g:signify_sign_delete_first_time = ''
let g:signify_sign_change = '~'

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gJ 9999<leader>gJ
nmap <leader>gK 9999<leader>gK

" Ctrl + a to select all text
map <C-a> <esc>ggVG<CR>

" "nm" to exit visual
xnoremap nm <Esc>

" Ctrl + c to copy text
vnoremap <C-c> "+y

" Rebind copying from "y" to "c"
" xnoremap c ygv

xnoremap <BS> "_d

" Move to next or previous file
map gn :bn<cr>
map gp :bp<cr>

" Shift + L keybindings in visual and normal modes
nnoremap <S-J> <C-D>
nnoremap <S-K> <C-U>
"nnoremap <S-Right> $
"nnoremap <S-Left> ^
nnoremap <S-L> w
nnoremap <S-H> b

vnoremap <S-J> <C-D>
vnoremap <S-K> <C-U>
"vnoremap <S-Right> $
"vnoremap <S-Left> ^
vnoremap <S-L> w
vnoremap <S-H> b

"colorscheme system76
colorscheme catppuccin-mocha

let g:auto_pairs_map_keys = 1

if (has("termguicolors"))
    set termguicolors
endif

" airline
source $HOME/.config/nvim/themes/airline.vim


lua require 'colorizer'.setup()
lua require('Comment').setup()

" NerdCommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv


" NerdTree
let NERDTreeQuitOnOpen=1
nmap <Tab> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" nnoremap nr :NERDTreeRefreshRoot<CR>

" Refresh NERDTree buffer and focus on current project's folder
nnoremap nr :NERDTreeRefreshRoot<CR>:NERDTreeRefreshRoot<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Coc
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Tabs
nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>
nmap <C-w> :bd<CR>

" Deletion
nnoremap <Delete> "_d
nnoremap d "_d

vnoremap <Delete> "_d

nnoremap ,<space> :nohlsearch<CR>

lua << EOF
require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules', '__pycache__', 'static', 'htmlcov', 'migrations', 'media', '.coverage', '^./.git/' },
  },
}

require('telescope').load_extension('fzf')
EOF

