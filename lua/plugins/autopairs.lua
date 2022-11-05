local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
local cmp_ok, cmp = pcall(require, "cmp")
if not autopairs_ok or not cmp_ok then
  return
end

autopairs.setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" }
})

autopairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))

cmp.event:on(
  "confirm_done",
  require("nvim-autopairs.completion.cmp").on_confirm_done()
)
