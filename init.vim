" ======================
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

" Fuzzy finder + dependency
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

" Snippets and completion (basic snippet engine)
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

" LSP and DevOps tools
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

call plug#end()

" ======================
" Colorscheme
" ======================
colorscheme tokyonight

" ======================
" Nvim-tree setup
" ======================
lua << EOF
require("nvim-tree").setup()
EOF
nnoremap <leader>e :NvimTreeToggle<CR>

" ======================
" Telescope setup and keymaps
" ======================
lua << EOF
require('telescope').setup{}
require('telescope').load_extension('fzf')
EOF
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>

" ======================
" Bufferline setup
" ======================
lua << EOF
require("bufferline").setup{}
EOF
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" ======================
" Notify setup
" ======================
lua << EOF
-- vim.notify = require("notify")
EOF

" ======================
" Dressing setup
" ======================
lua << EOF
require('dressing').setup()
EOF

" ======================
" ToggleTerm setup
" ======================
lua << EOF
require("toggleterm").setup{
  size = 20,
  open_mapping = [[<c-\>]],
  shading_factor = 2,
  direction = 'horizontal',
}
EOF
nnoremap <leader>t :ToggleTerm<CR>
tnoremap <Esc> <C-\><C-n>

" ======================
" Autopairs setup
" ======================
lua << EOF
require('nvim-autopairs').setup{}
EOF

" ======================
" Comment.nvim setup
" ======================
lua << EOF
require('Comment').setup()
EOF

" ======================
" Gitsigns setup
" ======================
lua << EOF
require('gitsigns').setup{}
EOF

" ======================
" Lualine + Navic
" ======================
lua << EOF
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
EOF

" ======================
" Project.nvim setup
" ======================
lua << EOF
require("project_nvim").setup {}
EOF

" ======================
" Auto-session setup
" ======================
lua << EOF
require('auto-session').setup {
  log_level = 'info',
  auto_session_enable_last_session = true,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
}
EOF

" ======================
" Markdown Preview keymap
" ======================
autocmd FileType markdown nnoremap <buffer> <leader>m :MarkdownPreviewToggle<CR>

" ======================
" Treesitter setup
" ======================
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "cpp", "lua", "python", "javascript", "typescript", "html", "css",
    "bash", "json", "markdown", "yaml", "dockerfile", "hcl"
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
}
EOF

" ======================
" Mason + LSP setup
" ======================
lua << EOF
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "bashls", "pyright", "yamlls", "jsonls", "dockerls", "terraformls", "marksman" },
}

local lspconfig = require("lspconfig")
local servers = { "bashls", "pyright", "yamlls", "jsonls", "dockerls", "terraformls", "marksman" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end
EOF

" ======================
" null-ls setup (formatters, linters)
" ======================
lua << EOF
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.shellcheck,
  },
})
EOF

" ======================
" Format buffer keymap
" ======================
nnoremap <leader>f :lua vim.lsp.buf.format({ async = true })<CR>

