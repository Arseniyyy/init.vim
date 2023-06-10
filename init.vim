set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
set clipboard=unnamedplus

set signcolumn=yes

set fileformat=unix
"filetype indent on      " load filetype-specific indent files
filetype plugin indent on

set t_Co=256

" for tabulation
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType typescriptreact setlocal shiftwidth=2
autocmd FileType json setlocal shiftwidth=4
set smartindent
set expandtab
set autoindent

let mapleader = ' '

" autoremove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

inoremap jk <esc>

call plug#begin()

Plug 'numToStr/Comment.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" JS, TS, JSX, TSX
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
"Plug 'prettier/vim-prettier', {
  "\ 'do': 'npm install --frozen-lockfile --production',
  "\ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'vim-python/python-syntax'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'LunarWatcher/auto-pairs'
Plug 'bmatcuk/stylelint-lsp'
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rhubarb'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Plug 'honza/vim-snippets'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.9.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" airline themes
Plug 'vim-airline/vim-airline-themes'

" color schemas
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
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

let g:python_highlight_all=1


autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" auto-pairs
let g:AutoPairsMapBS = 1
let g:AutoPairsMultilineBackspace = 1

" cgn
nnoremap <silent> c<Tab> :let @/=expand('<cword>')<cr>cgn

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

"colorscheme system76
colorscheme rose-pine

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

" Unhighlight highlighted text
nnoremap ,<space> :nohlsearch<CR>

" Set termguicolors
set termguicolors
hi DiagnosticError guifg=White
hi DiagnosticWarn  guifg=White
hi DiagnosticInfo  guifg=White
hi DiagnosticHint  guifg=White


lua << EOF
local luasnip = require 'luasnip'
local async = require "plenary.async"
local nvim_lsp = require 'lspconfig'

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
}

-- local null_ls = require("null-ls")
-- null_ls.setup({
--     sources = {
--         -- null_ls.builtins.diagnostics.eslint,
--         -- null_ls.builtins.code_actions.eslint,
--         null_ls.builtins.formatting.prettier
--     },
--     on_attach = on_attach
-- })

-- Stylelint format after save
require'lspconfig'.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      --autoFixOnSave = true,
      --autoFixOnFormat = true,
    }
  }
}
EOF

lua << EOF
require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules', '__pycache__', 'static', 'htmlcov', 'migrations', 'media', '.coverage', '^./.git/' },
  },
}

require('telescope').load_extension('fzf')
EOF

