--
-- @file      plugin_config/go.lua
-- @content   configuration for the "Go" plugin
--

local status, go = pcall(require, "go")

if not status then
    print("Cannot find plugin \"go\"...")
    return
end

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

go.setup ()
