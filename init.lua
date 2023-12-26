local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = ','

require("lazy").setup({
  'navarasu/onedark.nvim',
  { "neoclide/coc.nvim", branch = "release" },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",
  "tpope/vim-unimpaired",
  "mattn/emmet-vim",
  "itchyny/lightline.vim",
  "jremmen/vim-ripgrep",
  "stefandtw/quickfix-reflector.vim",
  "justinmk/vim-sneak",
  "qpkorr/vim-renamer",
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",
})

-- If on Windows, always use cmd.exe even if nvim was opened in bash (like in Git Bash)
if vim.fn.has('win32') or vim.fn.has('win64') then
  vim.o.shell = 'cmd.exe'
end

-- Theme
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- Filename at the bottom
vim.o.laststatus = 2
vim.o.statusline = vim.o.statusline .. '%{coc#status()}'

-- TextEdit might fail if 'hidden' is not set.
vim.o.hidden = true

-- Highlight current cursor line
vim.o.cursorline = true

-- Auto reload file when it changes
vim.o.autoread = true
vim.api.nvim_exec('autocmd CursorHold * checktime', false)

vim.o.timeoutlen = 300
vim.o.updatetime = 200

-- More natural split opening
vim.o.splitbelow = true
vim.o.splitright = true

-- Exclude node_modules from search
vim.o.path = vim.o.path .. '**'
vim.o.wildignore = vim.o.wildignore .. '**/node_modules/**'

-- Give more space for displaying messages.
vim.o.cmdheight = 2

-- Always show the signcolumn, otherwise, it would shift the text each time diagnostics appear/become resolved.
if vim.fn.has("patch-8.1.1564") then
  -- Recently vim can merge signcolumn and number column into one
  vim.o.signcolumn = 'number'
else
  vim.o.signcolumn = 'yes'
end

-- Set termguicolors to enable highlight groups
vim.o.termguicolors = true
vim.o.background = 'dark'

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Center cursor vertically when, e.g., searching
vim.o.scrolloff = 10
vim.o.number = true
vim.o.relativenumber = true

-- Include '-' in what vim sees as 1 word
-- vim.bo.iskeyword = vim.bo.iskeyword .. '-'

-- https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
vim.o.backspace = 'indent,eol,start'

-- Initialize NvimTree
-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Empty setup using defaults
require("nvim-tree").setup({
  view = {
    number = true,
    relativenumber = true,
  },
  update_focused_file = {
    enable = true,
  }
})

local keyset = vim.keymap.set

-- Disable automatic comment insert configuration file
keyset('n', '<leader>confe', ':e $MYVIMRC<CR>', { noremap = true })
-- Reload vim's configuration file
keyset('n', '<leader>confr', ':source $MYVIMRC<CR>', { noremap = true })

keyset('n', '<leader>to', ':NvimTreeOpen<CR>', {})
keyset('n', '<leader>tc', ':NvimTreeClose<CR>', {})

-- Rename in the current file's parent folder
keyset('n', '<leader>r', ':execute "Ren " . expand(\'%:p:h\')<CR>', { noremap = true })

-- Search files
local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.git_files, {})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Use <Tab> to confirm autocomplete selection with characters ahead and navigate
-- NOTE: There's always a complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugins before putting this into your config
keyset('i', '<Tab>', 'pumvisible() ? coc#pum#confirm() : v:lua.check_back_space() ? "<Tab>" : coc#refresh()', { expr = true })
keyset('i', '<S-Tab>', 'pumvisible() ? coc#pum#prev(1) : "<C-h>"', { expr = true })

-- Function to check backspace
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset('i', '<CR>', 'pumvisible() ? coc#pum#confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"', { expr = true })

-- Use <c-space> to trigger completion.
if vim.fn.has('nvim') then
  keyset('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true })
else
  keyset('i', '<c-@>', 'coc#refresh()', { silent = true, expr = true })
end

-- Split navigation
keyset('n', '<C-J>', '<C-W><C-J>', { noremap = true })
keyset('n', '<C-K>', '<C-W><C-K>', { noremap = true })
keyset('n', '<C-L>', '<C-W><C-L>', { noremap = true })
keyset('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- MacBook remaps
-- <M- means the command key
-- Cycle between last 2 buffers
keyset('n', '<M-z>', '<C-^>', { noremap = true })

-- Organize imports command
vim.api.nvim_create_user_command("OI", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
