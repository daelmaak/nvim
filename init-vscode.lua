local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end 
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'justinmk/vim-sneak'
});

-- Set mapleader
vim.g.mapleader = ','
vim.o.cmdheight=4

local keyset = vim.keymap.set

-- Disable search highlighting to prevent phantom text in VS Code
-- vim.o.hlsearch = false
-- Or if you want search highlighting but want to clear it automatically:
-- vim.o.hlsearch = true
-- Add a mapping to clear search highlighting
keyset('n', '<Esc>', '<Esc>:nohlsearch<CR>', { noremap = true, silent = true })

-- Key mappings
keyset('n', '<C-j>', "<Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>", { noremap = true })
keyset('n', '<C-k>', "<Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>", { noremap = true })
keyset('n', '<C-l>', "<Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>", { noremap = true })
keyset('n', '<C-h>', "<Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>", { noremap = true })

keyset('n', ']e', "<Cmd>call VSCodeNotify('next-error.next.error')<CR>", { noremap = true })
keyset('n', '[e', "<Cmd>call VSCodeNotify('next-error.prev.error')<CR>", { noremap = true })
keyset('n', ']g', "<Cmd>call VSCodeNotify('next-error.next.warning')<CR>", { noremap = true })
keyset('n', '[g', "<Cmd>call VSCodeNotify('next-error.prev.warning')<CR>", { noremap = true })
keyset('n', ']f', "<Cmd>call VSCodeNotify('next-error.nextInFiles.error')<CR>", { noremap = true })
keyset('n', '[f', "<Cmd>call VSCodeNotify('next-error.prevInFiles.error')<CR>", { noremap = true })
keyset('n', ']d', "<Cmd>call VSCodeNotify('next-error.nextInFiles.warning')<CR>", { noremap = true })
keyset('n', '[d', "<Cmd>call VSCodeNotify('next-error.prevInFiles.warning')<CR>", { noremap = true })

keyset('n', '<leader>qf', "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>", { noremap = true })
keyset('n', '<leader>gd', "<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>", { noremap = true })
keyset('n', '<leader>gr', "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>", { noremap = true })
keyset('n', '<leader>gi', "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>", { noremap = true })

keyset('n', '<leader>re', "<Cmd>call VSCodeNotify('revealInExplorer')<CR>", { noremap = true })
keyset('n', '<leader>rn', "<Cmd>call VSCodeNotify('editor.action.rename')<CR>", { noremap = true })
keyset('n', '<leader>oi', "<Cmd>call VSCodeNotify('editor.action.organizeImports')<CR>", { noremap = true })
keyset('n', '<leader>gb', "<Cmd>call VSCodeNotify('gitlens.toggleFileBlame')<CR>", { noremap = true })

keyset('n', ',qf', "<Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>", { noremap = true })

