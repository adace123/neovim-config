local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      ".git/",
      "target/",
      "vendor/*",
      "__pycache__",
      "node_modules",
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
  },

  pickers = {
    colorscheme = {
      enable_preview = true,
    },
    find_files = {
      theme = "dropdown",
    },
  },
})

local extensions = {
  "frecency",
  "projects",
  "zoxide",
  "session-lens",
}

for _, ext in pairs(extensions) do
  telescope.load_extension(ext)
end
