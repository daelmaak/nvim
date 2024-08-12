local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end 
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'justinmk/vim-sneak'
});

-- Detect the operating system
if not vim.g.os then
    if vim.fn.has('win64') or vim.fn.has('win32') or vim.fn.has('win16') then
        vim.g.os = 'Windows'
    else
        vim.g.os = vim.fn.substitute(vim.fn.system('uname'), '\n', '', '')
    end
end

-- Set mapleader
vim.g.mapleader = ','

local keyset = vim.keymap.set

cmdheight=0

-- Key mappings
keyset('n', '<C-j>', "<Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>", { noremap = true })
keyset('n', '<C-k>', "<Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>", { noremap = true })
keyset('n', '<C-l>', "<Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>", { noremap = true })
keyset('n', '<C-h>', "<Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>", { noremap = true })

keyset('n', ']g', "<Cmd>call VSCodeNotify('go-to-next-error.next.warning')<CR>", { noremap = true })
keyset('n', '[g', "<Cmd>call VSCodeNotify('go-to-next-error.prev.warning')<CR>", { noremap = true })

keyset('n', '<leader>qf', "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>", { noremap = true })
keyset('n', '<leader>gd', "<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>", { noremap = true })
keyset('n', '<leader>gr', "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>", { noremap = true })
keyset('n', '<leader>gi', "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>", { noremap = true })

keyset('n', '<leader>re', "<Cmd>call VSCodeNotify('revealInExplorer')<CR>", { noremap = true })
keyset('n', '<leader>rn', "<Cmd>call VSCodeNotify('editor.action.rename')<CR>", { noremap = true })
keyset('n', '<leader>oi', "<Cmd>call VSCodeNotify('editor.action.organizeImports')<CR>", { noremap = true })
keyset('n', '<leader>gb', "<Cmd>call VSCodeNotify('gitlens.toggleFileBlame')<CR>", { noremap = true })

keyset('n', ',qf', "<Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>", { noremap = true })

-- Support clipboard in WSL2
if vim.g.os == 'Linux' and (vim.fn.has('clipboard') or vim.g.vscode) then
    local clip = '/mnt/c/Windows/System32/clip.exe' -- Change this path according to your mount point
    if vim.fn.executable(clip) then
        vim.cmd([[
            augroup WSLYank
                autocmd!
                autocmd TextYankPost * if v:event.operator ==# 'y' | call system(clip, @0) | endif
            augroup END
        ]])
    end
end

-- Correct scrolling for MacOS
if vim.g.os == 'Darwin' then
    keyset('n', '<C-f>', "<Cmd>call VSCodeExtensionCall('scroll', 'page', 'down')<CR>", { expr = true, silent = true })
    keyset('x', '<C-f>', "<Cmd>call VSCodeExtensionCall('scroll', 'page', 'down')<CR>", { expr = true, silent = true })
    keyset('n', '<C-b>', "<Cmd>call VSCodeExtensionCall('scroll', 'page', 'up')<CR>", { expr = true, silent = true })
    keyset('x', '<C-b>', "<Cmd>call VSCodeExtensionCall('scroll', 'page', 'up')<CR>", { expr = true, silent = true })

    keyset('n', '<C-e>', "<Cmd>call VSCodeExtensionNotify('scroll-line', 'down')<CR>", { expr = true, silent = true })
    keyset('x', '<C-e>', "<Cmd>call VSCodeExtensionNotify('scroll-line', 'down')<CR>", { expr = true, silent = true })
    keyset('n', '<C-y>', "<Cmd>call VSCodeExtensionNotify('scroll-line', 'up')<CR>", { expr = true, silent = true })
    keyset('x', '<C-y>', "<Cmd>call VSCodeExtensionNotify('scroll-line', 'up')<CR>", { expr = true, silent = true })

    -- keyset('n', '<C-d>', "<Cmd>call VSCodeExtensionCall('scroll', 'halfPage', 'down')<CR>", { expr = true, silent = true })
    -- keyset('x', '<C-d>', "<Cmd>call VSCodeExtensionCall('scroll', 'halfPage', 'down')<CR>", { expr = true, silent = true })
    -- keyset('n', '<C-u>', "<Cmd>call VSCodeExtensionCall('scroll', 'halfPage', 'up')<CR>", { expr = true, silent = true })
    -- keyset('x', '<C-u>', "<Cmd>call VSCodeExtensionCall('scroll', 'halfPage', 'up')<CR>", { expr = true, silent = true })
end

