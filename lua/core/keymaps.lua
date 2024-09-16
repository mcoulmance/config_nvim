--
-- @file    core.keymaps.lua
-- @content Useful mappings for NVim
--

local keymap = vim.keymap.set

-- use space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- **** Editing Text **** --

-- return to file tree
keymap("n", "<leader>pv", vim.cmd.Ex)

-- open undo tree
keymap("n", "<leader>u", vim.cmd.UndotreeToggle)

-- select all
keymap("n", "<C-a>", ":keepjumps normal! ggVG<cr>")

-- By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
-- Press enter and then confirm each change you agree with y or decline with n.
keymap("v", "<C-r>", "hy:%s/<C-r>h//gc<left><left><left>")

-- Insert new line without leaving normal mode
keymap("n", "<leader>nl", "o<Esc>3\"_D")
keymap("n", "<leader>nL", "o<Esc>3\"_D")

-- indent all
keymap("n", "<C-J>", ":keepjumps normal! gg=G<CR>")

-- move text up and down
keymap("n", "mu", "<Esc>:m .-2<CR>==") -- up
keymap("n", "md", "<Esc>:m .+1<CR>==") -- down



-- **** Buffer **** --

-- create a new buffer
keymap("n", "<leader>new", ":new<Cr>")

-- close the current buffer and move to the previous one
keymap("n", "<leader>cls", ":bp <bar> bd #<cr>")

-- navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")


-- **** Windows **** --

-- split windows
keymap("n", "<leader>sh", ":split<cr>")
keymap("n", "<leader>sv", ":vsplit<cr>")

-- resize window
keymap("n", "<C-Left>", ":vertical resize +1<CR>")
keymap("n", "<C-Right>", ":vertical resize -1<CR>")
keymap("n", "<C-Down>", ":resize +1<CR>")


-- **** Fancy UI **** --

-- go to normal mode by pressing jk in insert and terminal mode
keymap("i", "jk", "<esc>")
keymap("t", "jk", "<C-\\><C-n>")

-- reload config without closing and reopening nvim
keymap("n", "<C-s><C-o>", ":so%<CR>")

-- remove all trailing whitespaces by pressing F5
keymap("n", "<F5>", [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]])

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>")

-- Open autocomplete popup
keymap("i", "<C-Space>", "<C-x><C-o>")
