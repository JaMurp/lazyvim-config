local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
    { "tpope/vim-commentary" },
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("lspconfig").clangd.setup({})
        require("lspconfig").pyright.setup({})
        require("lspconfig").tsserver.setup({})
        require("lspconfig").eslint.setup({})
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    },
    {
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        dap.adapters.python = {
          type = "executable",
          command = "python3",
          args = { "-m", "debugpy.adapter" },
        }
        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
              return "python3"
            end,
          },
        }
      end,
    },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "pyright", "tsserver" },
        })
      end,
    },
    {
      "windwp/nvim-autopairs",
      config = function()
        local npairs = require("nvim-autopairs")
        npairs.setup({
          disable_filetype = { "TelescopePrompt", "vim" },
          disable_in_macro = true, -- Disable auto-pairing in macros
          disable_in_visualblock = true, -- Disable auto-pairing in visual block mode
          disable_in_replace_mode = true, -- Disable auto-pairing in replace mode
        })
      end,
    },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
