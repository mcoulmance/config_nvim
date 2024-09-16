--
-- @file     plugin_config/lualine.lua
-- @content  Configuration file for lualine plugin
-- 
-- A nicer status bar for the bottom of the screen
--

local status, lualine = pcall(require, "lualine")

if not status then
    print("Plugin \"lualine\" not found...")
    return
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = 'vscode',
    },
    sections = {
        lualine_a = {
            {
                'filename',
                path = 1,
            }
        }
    }
})
