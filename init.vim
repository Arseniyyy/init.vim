set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
set clipboard+=unnamedplus

set signcolumn=yes

set fileformat=unix
filetype plugin indent on

" for tabulation
set tabstop=2
set shiftwidth=2
set nosmartindent
set expandtab
set noautoindent
set wrap
set cindent

"colors settings "
set termguicolors
highlight Type cterm=bold gui=bold

augroup MyHighlight
  autocmd!
  autocmd FileType java highlight javaType cterm=bold gui=bold
  autocmd FileType java highlight javaKeyword cterm=bold gui=bold
  autocmd FileType java highlight javaStorageClass cterm=bold gui=bold
  autocmd FileType java highlight javaBoolean cterm=bold gui=bold
augroup END

" updatetime for vim-gitgutter
set updatetime=100

let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

" Set shiftwidth for different file extensions
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascriptreact setlocal shiftwidth=2

autocmd FileType cpp setlocal shiftwidth=4
autocmd FileType cpp setlocal tabstop=4
autocmd FileType cpp setlocal softtabstop=4

autocmd FileType sql setlocal shiftwidth=4
autocmd FileType sql setlocal tabstop=4
autocmd FileType sql setlocal softtabstop=4

autocmd FileType sh setlocal shiftwidth=4
autocmd FileType sh setlocal tabstop=4
autocmd FileType sh setlocal softtabstop=4

" Java indentation settings
augroup filetypedetect
  au BufRead,BufNewFile *.java setfiletype java
augroup END

autocmd FileType java setlocal shiftwidth=4
autocmd FileType java setlocal tabstop=4
autocmd FileType java setlocal softtabstop=4
autocmd FileType java setlocal expandtab

" Set syntax highlight for .tsx and .jsx files
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

set t_Co=256
let mapleader = ' '

" autoremove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

inoremap jk <esc>

call plug#begin()

" lsp-servers
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-jdtls'
Plug 'nvim-lua/plenary.nvim'

" autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" JS, TS, JSX, TSX
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'


" Other
Plug 'vim-python/python-syntax'
Plug 'preservim/nerdtree'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'LunarWatcher/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'lambdalisue/suda.vim'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-rhubarb'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.9.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" airline themes
Plug 'vim-airline/vim-airline-themes'

" color schemas
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'lunarvim/colorschemes'
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'tomasiser/vim-code-dark'

Plug 'projekt0n/github-nvim-theme'
Plug 'ramojus/mellifluous.nvim'

call plug#end()

nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

highlight GitGutterAdd    guifg=#000000 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" colorscheme wal
" colorscheme github_light
" set background=light
colorscheme github_dark
set background=dark

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

" Assign "end" and "be" to jump to the end and the beginning of the line accordingly
nnoremap end $
nnoremap be 0

xnoremap end $
xnoremap be 0

" typescript-vim config
let g:typescript_indent_disable = 1

" Tailiwindcss
au FileType html let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']

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

" gitgutter config
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'

autocmd BufWritePost * GitGutter

" airline
source $HOME/.config/nvim/themes/airline.vim

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
" inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

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
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_lsp.default_capabilities()
cmp.setup({
  -- For snippet integration (if you installed LuaSnip and cmp_luasnip)
  snippet = {
    expand = function(args)
    require('luasnip').lsp_expand(args.body) -- Replace with your snippet engine if not LuaSnip
    end,
  },

  -- Keymapping for completion
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation window back
    ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Scroll documentation window forward
    ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion menu
    ['<C-e>'] = cmp.mapping.abort(),         -- Abort completion
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },   -- Suggestions from the LSP server (clangd)
    { name = 'buffer' },     -- Suggestions from words in the current buffer
    { name = 'path' },       -- Suggestions for file paths
  }),
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  experimental = {
      ghost_text = true, -- Shows a faint ghost text for the current completion
  },
})

local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'g', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'g', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'g', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'g', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'g', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'g', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'g', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'g', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Treesitter config
local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = {
    "typescript",
    "tsx",
    "c",
    "cpp",
    "java",
    "sql"
  },
  sync_install = false,
  ignore_install = { "python", "vim" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "python", "typescript", "tsx", "vim" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = {"java"} },
}

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
