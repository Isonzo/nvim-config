-- Vim options
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.foldmethod = "indent"
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.syntax = "on"

-- Global Leader keys
vim.g.mapleader = " "

-- Lazy.Nvim bootsrapper
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Colorschemes
  { "bluz71/vim-moonfly-colors", name = "moonfly", priority = 1000 },
  { "jacoborus/tender.vim" },

  -- Modern Completion Engine (Replaces raw coc popup bugs)
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- Modern Coc Tab mapping to prevent screen freezing/ghost characters
      vim.keymap.set("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"]], { expr = true, silent = true })
      
      -- Refresh Coc
      vim.keymap.set("n", "<F5>", ":CocRestart<CR><CR>", { silent = true })
      -- Format file
      vim.keymap.set("n", "<F6>", ":call CocAction('format')<CR>", { silent = true })
    end,
  },

  -- Syntax & Highlighting (Replaces legacy vim-hexokinase & rainbow brackets)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "c", "cpp", "zig", "nim", "asm", "lua", "vim", "vimdoc" },
      highlight = { enable = true },
    },
  },
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = true, -- Modern color previewer that doesn't break UI grids
  },

  -- File Tree & Navigation (Replaces NERDTree)
  {
    "stevearc/oil.nvim",
    opts = {},
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "<C-t>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Language-specific syntax packs
  { "ziglang/zig.vim" },
  { "zah/nim.vim" },
  { "habamax/vim-godot" },
})

-- =================================================================
-- USER KEYMAPS & UTILITIES
-- =================================================================
-- Load moonfly theme safely
vim.cmd.colorscheme("moonfly")

-- Fail-safe command to nuke orphaned floating windows instantly if language server hiccups
vim.api.nvim_create_user_command("KillFloats", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end, {})

vim.keymap.set("n", "<C-w>f", ":KillFloats<CR>", { silent = true })

-- Assembly syntax override
vim.api.nvim_create_autocmd({"BufReadPre", "BufNewFile"}, {
  pattern = "*.asm",
  callback = function()
    vim.g.asmsyntax = "fasm"
  end,
})
-- Jump to definition fallback (Nim/C tags)
vim.keymap.set("n", "<M-g>", ":tag<CR>", { silent = true })
