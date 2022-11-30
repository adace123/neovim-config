local M = {}
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return M
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

local function select_client(method)
	local clients = vim.tbl_values(vim.lsp.get_active_clients())
	clients = vim.tbl_filter(function(client)
		return client.supports_method(method)
	end, clients)

	if clients == nil or next(clients) == nil then
		return nil
	end

	return clients
end

function M.set_keymaps(bufnr)
	local status_aerial, _ = pcall(require, "aerial")
	local map = require("core/mappings").map
	local diagnostic_mappings = {
		n = {
			["[d"] = vim.diagnostic.goto_prev,
			["]d"] = vim.diagnostic.goto_next,
		},
	}

	local buf_mappings = {
		n = {
			["gd"] = vim.lsp.buf.definition,
			["gR"] = vim.lsp.buf.rename,
			["gr"] = vim.lsp.buf.references,
			["gy"] = vim.lsp.buf.type_definition,
			["K"] = vim.lsp.buf.hover,
			["ga"] = vim.lsp.buf.code_action,
			["gs"] = vim.lsp.buf.signature_help,
		},
	}

	map(diagnostic_mappings)
	map(buf_mappings, { buffer = bufnr })

	if status_aerial then
		local aerial_mappings = {
			n = {
				["{"] = "<cmd>AerialPrev<CR>",
				["}"] = "<cmd>AerialNext<CR>",
				["<Leader>a"] = "<cmd>AerialToggle!<CR>",
			},
		}
		map(aerial_mappings, { buffer = bufnr })
	end
end

function M.set_autocmds(client, bufnr)
	local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

	if select_client("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end

	if client.supports_method("textDocument/documentHighlight") then
		vim.api.nvim_create_autocmd("CursorHold", {
			pattern = "*",
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
			group = group,
		})

		vim.api.nvim_create_autocmd("CursorMoved", {
			pattern = "*",
			callback = function()
				vim.lsp.buf.clear_references()
			end,
			group = group,
		})
	end
end

function M.setup(opts)
	local config = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
		},
		hover = {
			border = "rounded",
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
	}

	vim.diagnostic.config(config)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.hover)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

function M.on_attach(client, bufnr)
	local status_navic, navic = pcall(require, "nvim-navic")
	local status_illuminate, illuminate = pcall(require, "illiuminate")

	if status_navic and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	if status_illuminate then
		illuminate.on_attach(bufnr)
	end

	M.set_keymaps(bufnr)
	M.set_autocmds(client, bufnr)
end

return M
