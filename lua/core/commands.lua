vim.api.nvim_create_user_command("PackerReload", function(_args)
	vim.cmd([[source ~/.config/nvim/lua/plugins/init.lua | PackerSync]])
end, {})
