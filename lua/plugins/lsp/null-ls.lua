local M = {}
local handlers = require("plugins/lsp/handlers")

function M.setup()
  local null_ls_ok, null_ls = pcall(require, "null-ls")
  if not null_ls_ok then
    return
  end

  local formatters = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  local hover = null_ls.builtins.hover

  null_ls.setup({
    sources = {
      -- formatters
      formatters.prettier,
      formatters.black.with({ extra_args = { "--fast" } }),
      formatters.isort,
      formatters.stylua,
      formatters.rustfmt,
      formatters.alejandra,
      formatters.yamlfmt,
      formatters.zigfmt,
      formatters.gofmt,
      formatters.fixjson,
      formatters.goimports,
      formatters.autopep8,
      formatters.taplo,
      formatters.terraform_fmt,

      -- diagnostics
      diagnostics.flake8.with({ extra_args = { "--max-line-length=100" } }),
      diagnostics.tsc,
      diagnostics.actionlint,
      diagnostics.ansiblelint,
      diagnostics.buf,
      diagnostics.jsonlint,
      diagnostics.shellcheck,
      diagnostics.statix,
      diagnostics.yamllint,

      -- code actions
      code_actions.eslint,
      code_actions.gitsigns,
      code_actions.statix,

      -- hover
      hover.printenv,
    },
  })
end

return M
