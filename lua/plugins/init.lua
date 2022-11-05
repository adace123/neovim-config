local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Autocommand that reloads neovim whenever you save the plugins/init.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*/nvim/lua/plugins/init.lua" },
  group = group,
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname ~= "init.lua" then
      vim.cmd([[source <afile> | PackerSync]])
    end
  end,
})

packer.init({
  snapshot_path = vim.fn.stdpath("config") .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
    prompt_border = "rounded",
  },
})

local plugins = {
  ["wbthomason/packer.nvim"] = {},
  ["lewis6991/impatient.nvim"] = {},

  -- lsp
  ["neovim/nvim-lspconfig"] = {
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "whoIsSethDaniel/mason-tool-installer.nvim",
      "folke/neodev.nvim",
    },
    config = function()
      require("plugins/lsp")
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("plugins/lsp/null-ls").setup()
    end,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    config = function()
      require("plugins/treesitter").setup()
    end,
  },
  ["RRethy/vim-illuminate"] = {
    config = function()
      require("illuminate").configure({})
    end,
  },
  ["j-hui/fidget.nvim"] = {
    config = function()
      require("fidget").setup({})
    end,
  },
  ["simrat39/rust-tools.nvim"] = {},
  ["Saecki/crates.nvim"] = {
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
  },

  -- utils
  ["nvim-lua/lsp-status.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = {},

  ["windwp/nvim-autopairs"] = {
    config = function()
      require("plugins/autopairs")
    end,
  },
  ["numToStr/Comment.nvim"] = {
    config = function()
      require("Comment").setup({
        ignore = "^$",
      })
    end,
  },
  ["stevearc/aerial.nvim"] = {
    config = function()
      require("aerial").setup({})
    end,
  },
  ["SmiteshP/nvim-navic"] = {},
  ["folke/trouble.nvim"] = {
    config = function()
      require("trouble").setup({})
    end,
  },
  ["folke/neodev.nvim"] = {
    config = function()
      require("neodev").setup({})
    end,
  },

  -- notifications
  ["rcarriga/nvim-notify"] = {
    config = function()
      local notify = require("notify")
      notify.setup({})
      vim.notify = notify
    end,
  },

  -- completion
  ["hrsh7th/nvim-cmp"] = {
    config = function()
      require("plugins/cmp")
    end,
  },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = {},
  ["hrsh7th/cmp-nvim-lsp"] = {},
  ["hrsh7th/cmp-path"] = {},
  ["hrsh7th/cmp-buffer"] = {},
  ["hrsh7th/cmp-cmdline"] = {},
  ["nvim-lualine/lualine.nvim"] = {
    config = function()
      require("lualine").setup({})
    end,
  },
  ["L3MON4D3/LuaSnip"] = {},
  ["rafamadriz/friendly-snippets"] = {},

  -- icons
  ["nvim-tree/nvim-web-devicons"] = {
    config = function()
      require("nvim-web-devicons").setup({})
    end,
  },
  ["ryanoasis/vim-devicons"] = {},

  -- themes
  ["rebelot/kanagawa.nvim"] = {},

  -- git
  ["lewis6991/gitsigns.nvim"] = {
    config = function()
      require("gitsigns").setup({
        sign_priority = 100,
        preview_config = {
          border = "rounded",
        },
      })
    end,
  },
}

return packer.startup(function(use)
  for name, plugin in pairs(plugins) do
    plugin[1] = name
    use(plugin)
  end
end)
