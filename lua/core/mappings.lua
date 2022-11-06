local M = {}
local opts = { noremap = true, silent = true }

M.map = function(map_table, extra_opts)
	if extra_opts ~= nil and next(extra_opts) ~= nil then
		opts = vim.tbl_deep_extend("force", opts, extra_opts)
	end

	for mode, mappings in pairs(map_table) do
		for from, to in pairs(mappings) do
			vim.keymap.set(mode, from, to, opts)
		end
	end
end

vim.api.nvim_set_keymap("n", "<Space>", "", {})
vim.g.mapleader = " "

local base_mappings = {
	i = {
		-- remap escape
		["jj"] = "<Esc>",
		["jk"] = "<Esc>",
		["kj"] = "<Esc>",

		-- paste and jump to end
		["<C-v>"] = "<Esc>p`]A",

		-- delete text in front of cursor
		["<C-k>"] = "<Esc>d$a",

		-- navigation
		["<C-d>"] = "<Esc><C-d>i",
		["<C-u>"] = "<Esc><C-u>i",

		-- save
		["<C-s>"] = "<Esc><cmd>w!<cr>i",

		-- undo
		["<C-z>"] = "<Esc>ui",
	},
	[""] = {
		-- window navigation
		["<C-h>"] = "<C-w>h",
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
		["<C-l>"] = "<C-w>l",
		["<C-q>"] = "<C-w>q",
	},
	n = {
		-- paste on new line
		["<C-p>"] = "o<Esc>p",

		-- delete buffer
		["<S-x>"] = ":bdelete<CR>",

		-- buffer navigation
		["<S-l>"] = ":bnext<CR>",
		["<S-h>"] = ":bprevious<CR>",

		-- tab indentation
		["<Tab>"] = ">>_",
		["S-Tab"] = "<<_",

		-- save
		["<C-s>"] = "<cmd>w!<cr>",

		-- newlines
		["<CR>"] = "o<Esc>",
		["<BS>"] = "dd",

		-- turn off highlighting
		["<Leader>h"] = "<cmd>noh<CR>",

		-- quit
		["<C-x>"] = "<cmd>q!<CR>",
	},
	v = {
		-- stay in indent mode
		["<"] = "<gv",
		[">"] = ">gv",

		-- move text up and down
		["<A-j>"] = ":m .+1<CR>==",
		["<A-k>"] = ":m .-2<CR>==",
		["p"] = '"_dP',

		-- tab indentation
		["<Tab>"] = ">>_",
		["S-Tab"] = "<<_",

		-- reload config
		["<Leader>t"] = "<cmd>luafile %<CR>",
	},
}

local extra_mappings = {
	n = {
		-- Comment.nvim
		["<Leader>/"] = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
	},
	v = {
		-- Comment.nvim
		["<Leader>/"] = "<Plug>(comment_toggle_linewise_visual)",
	},
}

function M.setup()
	M.map(base_mappings)
	M.map(extra_mappings)
end

return M
