local M = {
  override_default_setup = true,
}

function M.setup(opts)
  local rt_ok, rt = pcall(require, "rust-tools")
  if not rt_ok then
    return
  end

  rt.setup({
    server = {
      on_attach = opts.on_attach,
      settings = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  })
end

return M
