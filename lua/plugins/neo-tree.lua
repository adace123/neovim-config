local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
  return
end

local current_dir = vim.fn.getcwd()

local fs = require("neo-tree.sources.filesystem")
local cmds = require("neo-tree.sources.filesystem.commands")

neotree.setup({
  close_if_last_window = true,
  source_selector = {
    winbar = true,
    content_layout = "center",
  },
  window = {
    width = 30,
  },
  filesystem = {
    commands = {
      navigate_working_dir = function(state)
        -- Navigate back to current working dir
        cmds.clear_filter(state)
        fs.navigate(state, current_dir)
      end,
    },
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ["h"] = "toggle_hidden",
        ["N"] = "navigate_working_dir",
      },
    },
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_pattern = {
        ".git",
        "node_modules",
        "target/debug/*",
      },
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(_)
        vim.opt_local.signcolumn = "auto"
      end,
    },
  },
})
