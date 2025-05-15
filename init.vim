" Basic settings
" ======================
set number
set relativenumber
set tabstop=4
let mapleader = " "
set shiftwidth=4
set expandtab
set smartindent
set cursorline
set nowrap
set ignorecase
set smartcase
set nohlsearch
set incsearch
set mouse=a
set clipboard=unnamedplus
set termguicolors
set sessionoptions=localoptions

" ======================
" Plugin manager setup
" ======================
call plug#begin('~/.vim/plugged')

" Theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" File explorer
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Fuzzy finder + dependencies
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" UI Enhancements
Plug 'akinsho/bufferline.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'stevearc/dressing.nvim'

" Terminal integration
Plug 'akinsho/toggleterm.nvim'

" Code navigation & editing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim'

" Git integration
Plug 'lewis6991/gitsigns.nvim', {'tag': 'v0.6' }
Plug 'tpope/vim-fugitive'

" Statusline & Winbar
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-navic'

" Snippets and completion
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'

" Project management
Plug 'ahmedkhalf/project.nvim'

" Session management
Plug 'rmagatti/auto-session'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install', 'for': 'markdown' }

" Startup performance
Plug 'lewis6991/impatient.nvim'

" LSP and tooling
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

call plug#end()

" ======================
" Colorscheme
" ======================
colorscheme tokyonight

" ======================
" Lua configs
" ======================
lua << EOF
-- Setup nvim-tree
require("nvim-tree").setup()

-- Telescope setup
require('telescope').setup{}
require('telescope').load_extension('fzf')

-- Bufferline setup
require("bufferline").setup{}

-- Notify (optional)
-- vim.notify = require("notify")

-- Dressing
require('dressing').setup()

-- Toggleterm
require("toggleterm").setup{
  size = 20,
  open_mapping = [[<c-\>]],
  shading_factor = 2,
  direction = 'horizontal',
}

-- Autopairs
require('nvim-autopairs').setup{}

-- Comment.nvim
require('Comment').setup()

-- Gitsigns
require('gitsigns').setup{}

-- Lualine + Navic
require('lualine').setup{
  options = {
    theme = 'tokyonight',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_c = {
      { 'filename' },
      { require('nvim-navic').get_location, cond = require('nvim-navic').is_available }
    }
  },
}
require('nvim-navic').setup {
  highlight = true,
  separator = ' > ',
  depth_limit = 5,
  depth_limit_indicator = '..',
}

-- Project.nvim
require("project_nvim").setup {}

-- Auto-session
require('auto-session').setup {
  log_level = 'info',
  auto_session_enable_last_session = true,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "cpp", "lua", "python", "javascript", "typescript", "html", "css",
    "bash", "json", "markdown", "yaml", "dockerfile", "hcl"
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
}

-- Mason + lspconfig setup
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
local servers = { "bashls", "pyright", "yamlls", "jsonls", "dockerls", "terraformls", "marksman" }

for _, server in ipairs(servers) do
  lspconfig[server].setup{}
end

EOF

" ======================
" Keymaps
" ======================
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>t :ToggleTerm<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>f :lua vim.lsp.buf.format()<CR>
autocmd FileType markdown nnoremap <buffer> <leader>m :MarkdownPreviewToggle<CR>
