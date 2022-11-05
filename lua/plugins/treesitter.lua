local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
local M = {}

if not treesitter_ok then
	return M
end

function M.setup()
	treesitter.setup({
		ensure_installed = {
			"rust",
			"lua",
			"python",
			"bash",
			"go",
			"javascript",
			"json",
			"typescript",
			"yaml",
			"zig",
		},
		auto_install = true,
		ident = { enable = true },
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		},
	})
end

return M
