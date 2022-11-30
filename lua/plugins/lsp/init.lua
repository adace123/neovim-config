local status_ok_mason, mason = pcall(require, "mason")
local status_ok_mason_lspconfig, mason_lsp_config = pcall(require, "mason-lspconfig")
local status_ok_mason_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")

local missing_required_packages = (
    not status_ok_lspconfig
        or not status_ok_mason
        or not status_ok_mason_lspconfig
        or not status_ok_mason_tool_installer
    )
if missing_required_packages then
  return
end

mason.setup({})

local handlers = require("plugins/lsp/handlers")

local mason_tools = {
  -- servers
  "gopls",
  "json-lsp",
  "python-lsp-server",
  "rust-analyzer",
  "lua-language-server",
  "yaml-language-server",
  "bash-language-server",
  "zls",
  "typescript-language-server",
  "taplo",

  -- formatters
  "stylua",
  "black",
  "isort",
  "shellcheck",
  "selene",
  "autopep8",
  "prettier",
  "yamlfmt",
  "yamllint",
}

-- tools not available through mason
local lsp_extra = {
  "nil_ls",
}

mason_tool_installer.setup({
  ensure_installed = mason_tools,
  run_on_start = true,
  automatic_installation = true,
})

local function setup_lsp_server(server_name)
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
  local use_default_setup = true

  local status_ok, lsp_settings = pcall(require, "plugins/lsp/settings/" .. server_name)
  if status_ok then
    if lsp_settings.override_default_setup then
      use_default_setup = false
      lsp_settings.setup(opts)
    else
      vim.tbl_deep_extend("force", lsp_settings, opts)
    end
  end

  if use_default_setup then
    lspconfig[server_name].setup(opts)
  end
end

mason_lsp_config.setup_handlers({
  setup_lsp_server,
})

handlers.setup()

for _, server_name in pairs(lsp_extra) do
  setup_lsp_server(server_name)
end
