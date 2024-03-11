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

-- disable netrw (Vim's file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.user_emmet_leader_key='<C-Z>'

vim.g.coc_global_extensions = {'coc-json', '@yaegassy/coc-tailwindcss3'}

vim.g.hlsearch = true

require("lazy").setup({
  'navarasu/onedark.nvim',
  { "neoclide/coc.nvim", branch = "release" },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  'tpope/vim-unimpaired',
  'mattn/emmet-vim',
  'itchyny/lightline.vim',
  'jremmen/vim-ripgrep',
  -- 'mhinz/vim-grepper',
  'stefandtw/quickfix-reflector.vim',
  'justinmk/vim-sneak',
  'qpkorr/vim-renamer',
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  'neovim/nvim-lspconfig', 
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'github/copilot.vim',
  'rmagatti/auto-session',
  'okuuva/auto-save.nvim',
  -- To remove hlsearch after search is done
  'romainl/vim-cool',
})

require'auto-session'.setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "/"},
}

require'auto-save'.setup {}

-- Theme
require'onedark'.setup {
    style = 'darker',
    term_colors = true,
}
require'onedark'.load()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "c", "css", "diff", "gitcommit", "git_rebase", "lua", "vim", "vimdoc", "query", "tsx", "typescript" 
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  -- I commented highlight because it breaks diff highlighting in gitcommit
  -- highlight = {
  --   enable = true,
  -- }
}

require'nvim-tree'.setup {
  actions = {
    open_file = {
      -- This window picker thing kept asking me in which split I'd like to open the file which was annoying, so I disabled it
      window_picker = {
        enable = false,
      },
    },
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    number = true,
    relativenumber = true,
    width = 50,
  },
}

-- The -i flag is to make zsh use aliases in :term or :!{cmd} which otherwise wouldn't be used
vim.o.shell = '/usr/bin/zsh -i'

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
vim.o.scrolloff = 5
vim.o.number = true
vim.o.relativenumber = true

-- Include '-' in what vim sees as 1 word
-- vim.bo.iskeyword = vim.bo.iskeyword .. '-'

-- https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
vim.o.backspace = 'indent,eol,start'

vim.keymap.del('n', '<Plug>Sneak_,')

local keyset = vim.keymap.set

-- Disable automatic comment insert configuration file
keyset('n', '<leader>confe', ':e $MYVIMRC<CR>', { noremap = true })
-- Reload vim's configuration file
keyset('n', '<leader>confr', ':source $MYVIMRC<CR>', { noremap = true })

keyset('n', '<leader>to', ':NvimTreeOpen<CR>', {})
keyset('n', '<leader>tc', ':NvimTreeClose<CR>', {})
keyset('n', '<leader>tf', ':NvimTreeFocus<CR>', {})

keyset('n', '<leader>gg', ':vert G<CR>', {})

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
keyset("n", "gs", ":vsp<CR><Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
--
-- Organize imports command
keyset('n', "<leader>oi", ":call CocActionAsync('organizeImport')<CR>", {silent = true})

keyset('n', '<leader>ca', '<Plug>(coc-codeaction-cursor)', {silent = true})
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", {silent = true, nowait = true})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Use <Tab> to confirm autocomplete selection with characters ahead and navigate
-- NOTE: There's always a complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugins before putting this into your config
keyset('i', '<Tab>', 'pumvisible() ? coc#pum#confirm() : v:lua.check_back_space() ? "<Tab>" : coc#refresh()', { expr = true })
keyset('i', '<S-Tab>', 'pumvisible() ? coc#pum#prev(1) : "<C-h>"', { expr = true })

keyset('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Function to check backspace
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset('i', '<CR>', 'pumvisible() ? coc#pum#confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"', { expr = true })
--

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

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


