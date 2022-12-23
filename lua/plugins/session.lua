local status_ok, session = pcall(require, "auto-session")
if not status_ok then
  return
end

session.setup({
  auto_save_enabled = true,
  auto_restore_enabled = true,
})
