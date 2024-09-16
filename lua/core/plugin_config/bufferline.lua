--
-- @file plugin_config/bufferline.lua
-- @content  Configuration for the bufferline plugin.
--
-- Display the list of all currently opened buffer on top of the screen
--

local status, bufferline = pcall(require, "bufferline")

if not status then
    print('Plugin "bufferlin" not found...')
    return
end

bufferline.setup({
    options = {
        mode = "buffers",
        separator_style = "thin",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_buffer_icons = true,
        show_tap_indicators = true,
        color_icons = true,
        diagnostics = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "center",
                separator = true,
                padding = 1,
            }
        }
    }
})

vim.keymap.set('n', '<Tab>', "<Cmd>BufferLineCycleNext<CR>")
vim.keymap.set('n', '<S-Tab>', "<Cmd>BufferLineCyclePrev<CR>")
