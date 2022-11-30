local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local config = {
  window = {
    border = "rounded",
  },
}

local normal = {
  opts = {
    mode = "n",
    prefix = "<Leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  },
  mappings = {
    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<CR>", "Find File" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
      s = { "<cmd>Telescope grep_string<cr>", "Find String" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
    },
    ["h"] = { "<cmd>noh<CR>", "No Highlight" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>TroubleToggle<CR>", "Diagnostics" },
      i = { "<cmd>LspInfo<CR>", "Info" },
      j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next Diagnostic" },
      k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", "Prev Diagnostic" },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    },
    ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment" },
    ["e"] = { "<cmd>Neotree toggle<CR>", "Explorer" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  s = {
    name = "Session",
    s = { "<cmd>SaveSession<cr>", "Save" },
    r = { "<cmd>RestoreSession<cr>", "Restore" },
    x = { "<cmd>DeleteSession<cr>", "Delete" },
    f = { "<cmd>Autosession search<cr>", "Find" },
    d = { "<cmd>Autosession delete<cr>", "Find Delete" },
  },
  t = {
    name = "Tab",
    n = { "<cmd>tabnext<CR>", "Next Tab" },
    p = { "<cmd>tabprev<CR>", "Prev Tab" },
  },
}

local visual = {
  opts = {
    mode = "v",
    prefix = "<Leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  },
  mappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment" },
  },
}

which_key.setup(config)
which_key.register(normal.mappings, normal.opts)
which_key.register(visual.mappings, visual.opts)
