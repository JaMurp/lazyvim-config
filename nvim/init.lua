-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

--Ctr d and u center
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Set relative and absolute line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Customize the appearance of line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#b19cd9" }) -- Pastel light purple color for line numbers
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#5eacd3", bg = "#3c3836", bold = true }) -- Customize to show indentation effect

-- Disable cursor line highlighting in normal mode
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:n",
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- Enable cursor line highlighting in visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "v:*",
  callback = function()
    vim.wo.cursorline = true
  end,
})

-- Add extra space to the line number column for the indentation effect
vim.cmd([[ set numberwidth=5 ]])

-- Create an autocommand to dynamically update the line number column width
vim.api.nvim_create_autocmd("CursorMoved", {
  pattern = "*",
  callback = function()
    vim.wo.numberwidth = vim.fn.line(".") == vim.fn.line("$") and 6 or 5
  end,
})

-- Remap Enter to perform the action of } in normal mode
vim.api.nvim_set_keymap("n", "<CR>", "}", { noremap = true, silent = true })

-- Remap Backspace to perform the action of { in normal mode
vim.api.nvim_set_keymap("n", "<BS>", "{", { noremap = true, silent = true })

-- Additional settings for improved experience
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20" -- Sets the cursor style to block in all modes
vim.opt.nu = true -- Enables absolute line numbers
vim.opt.relativenumber = true -- Enables relative line numbers
vim.opt.tabstop = 4 -- Sets the number of spaces a tab character represents
vim.opt.softtabstop = 4 -- Sets the number of spaces a tab press inserts
vim.opt.shiftwidth = 4 -- Sets the number of spaces used for each step of (auto)indent
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smartindent = true -- Automatically inserts indents in a smart way
vim.opt.wrap = false -- Disables line wrapping
vim.opt.swapfile = false -- Disables swap file creation
vim.opt.backup = false -- Disables backup file creation
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Sets the directory for undo files
vim.opt.undofile = true -- Enables persistent undo
vim.opt.hlsearch = false -- Disables highlighting all search matches
vim.opt.incsearch = true -- Enables incremental search
vim.opt.termguicolors = true -- Enables true color support
vim.opt.scrolloff = 17 -- Keeps 17 lines visible above and below the cursor
vim.opt.signcolumn = "yes" -- Always shows the sign column
vim.opt.isfname:append("@-@") -- Adds '@-@' to the list of file name characters
vim.opt.updatetime = 50 -- Sets the time (ms) before triggering CursorHold event

-- Auto-save settings
-- Auto-save on leaving insert mode, switching buffers, and losing focus
vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "FocusLost" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})

-- Auto-save every 2 minutes (120000 milliseconds)
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Key mappings for indenting and outdenting in visual mode
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

vim.o.cursorline = false

vim.g.loaded_matchparen = 1 -- Disable matchparen plugin

-- Explicitly set formatoptions to not auto-pair brackets or parentheses
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")
