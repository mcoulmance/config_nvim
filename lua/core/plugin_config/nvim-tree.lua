--
-- @file plugin_config/nvim-tree.lua
-- @content  Configuration for nvim-tree plugin
--
-- An embedded file explorer that displays current directory on the
-- left side of the screen
--

local status, ntree = pcall(require, "nvim-tree")

if not status then
    print('Plugin "nvim-tree" not found...')
    return
end


ntree.setup({
    hijack_cursor = false,
    disable_netrw = false,
    hijack_netrw = false,
})

vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")


