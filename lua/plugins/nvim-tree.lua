local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config = {
	hijack_directories = {
		enable = false,
	},
	update_focused_file = {
		enable = true,
	},
	open_on_setup = true,
	filters = {
		custom = { ".git" },
		exclude = { ".gitignore" },
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	view = {
		mappings = {
			list = {
				{ key = "s", action = "vsplit" },
				{ key = "S", action = "split" },
			},
		},
	},
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
}

nvim_tree.setup(config)
