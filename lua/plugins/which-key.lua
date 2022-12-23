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
      b = { "<cmd>Telescope buffers<CR>", "Find Buffer" },
      m = { "<cmd>Telescope marks<CR>", "Find Mark" },
      f = { "<cmd>Telescope find_files<CR>", "Find File" },
      c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
      w = { "<cmd>Telescope live_grep<CR>", "Find Text" },
      s = { "<cmd>Telescope grep_string<CR>", "Find String" },
      g = {
        name = "Git",
        s = { "<cmd>Telescope git_status<CR>", "Status" },
        c = { "<cmd>Telescope git_commit<CR>", "Commits" },
        b = { "<cmd>Telescope git_branches<CR>", "Branches" },
      },
      p = { "<cmd>Telescope projects<CR>", "Projects" },
      r = { "<cmd>Telescope oldfiles<CR>", "Recent File" },
      R = { "<cmd>Telescope registers<CR>", "Registers" },
      k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
      C = { "<cmd>Telescope commands<CR>", "Commands" },
      z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
    },
    ["h"] = { "<cmd>noh<CR>", "No Highlight" },
    ["d"] = { "<cmd>lua require('notify').dismiss()<CR>", "Dismiss Notfications" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      t = { "<cmd>TroubleToggle<CR>", "Diagnostics" },
      i = { "<cmd>LspInfo<CR>", "Info" },
      j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next Diagnostic" },
      k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", "Prev Diagnostic" },
      l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      R = { "<cmd>TroubleToggle lsp_references<CR>", "References" },
    },
    ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<CR>", "Compile" },
      i = { "<cmd>PackerInstall<CR>", "Install" },
      r = { "<cmd>PackerReload<CR>", "Reload" },
      s = { "<cmd>PackerSync<CR>", "Sync" },
      S = { "<cmd>PackerStatus<CR>", "Status" },
      u = { "<cmd>PackerUpdate<CR>", "Update" },
    },
    s = {
      name = "Session",
      s = { "<cmd>SaveSession<CR>", "Save" },
      r = { "<cmd>RestoreSession<CR>", "Restore" },
      x = { "<cmd>DeleteSession<CR>", "Delete" },
      f = { "<cmd>Autosession search<CR>", "Find" },
      d = { "<cmd>Autosession delete<CR>", "Find Delete" },
    },
    t = {
      name = "Tab",
      n = { "<cmd>tabnext<CR>", "Next Tab" },
      p = { "<cmd>tabprev<CR>", "Prev Tab" },
      x = { "<cmd>tabclose<CR>", "Close Tab" },
    },
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
