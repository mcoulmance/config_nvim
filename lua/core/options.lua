--
-- @file 	options.lua
-- @content 	Basic configuration for NVim
--

local set = vim.opt

set.guicursor = "n-v-c-i:block,r-cr:hor20,o:hor50,i-ci:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175,v:hor30-blinkwait700-blinkoff400-blinkon250"                              -- big cursor

set.incsearch = true				            -- show match for partly search command
set.ignorecase = true				            -- ignore case when using search pattern
set.smartcase = true				            -- override 'ignorecase' when pattern has upper case characters

set.wrap = false				                -- long lines wrap
set.cmdheight = 1				                -- number of lines used for the command line
set.number = true				                -- show the line number for each line
set.scrolloff = 10				                -- number of screen lines to show around the cursor
set.breakindent = true				            -- preserve indentation in wrapped text
set.sidescroll = 1				                -- minimul number of columns to scroll horizontally

set.background = "dark"				            -- "dark" or "light"; the background color brightness
set.hlsearch = true				                -- highlight all matches for the last uses search pattern
set.cursorline = false				            -- don't highlight the screen line of cursor
set.termguicolors = true			            -- use GUI colors for the terminal

set.splitright = true				            -- vertically-split window is put right of the current one
set.splitbelow = true				            -- horizontally-split window is put below of the current one

set.title = true		    		            -- show info on the window title

set.showcmd = true				                -- show (partial) command keys in the status line
set.showmode = true				                -- display the current mode in the status line
set.confirm = true				                -- start a dialog when a command fails

set.autoindent = true                           -- automatically set the indent of a newline
set.smartindent = true                          -- do clever autoindenting
set.tabstop = 2                                 -- number of space a <Tab> in the text stands for
set.shiftwidth = 2                              -- number of spaces used for each step of (auto)indent
set.backspace = { "indent", "eol", "start" }    -- specifies what <BS>, CTRL-w, etc. can do in Insert mode
set.expandtab = true                            -- expand <Tab> to spaces in Insert mode

--set.clipboard:prepend { "unnamedplus" }         -- to put selected text on the clipboard
set.fillchars.eob = " "                         -- hiding ~ that indicates filler lines
set.timeout = true                                  
set.timeoutlen = 500                            -- time to wait for a mapped sequence to complete (in milliseconds)
set.undofile = true                             -- enable persistent undo
set.updatetime = 400                            -- faster completion (4000ms default)
set.signcolumn = "no"                           -- never show the sign column
--set.cc = "80"                                     -- highlight column 80 for code hygiene
--vim.opt.highlight.cc="White"

vim.cmd "set whichwrap+=<,>,[,],h,l"            -- wrap text at both left and right
vim.cmd [[set iskeyword+=-]]                    -- ask vim to treat '-' like a regular word character that should be skipped over by things like w or b

set.completeopt = { "menuone", "menu", "noselect", "preview" } -- mainly for cmp plugin

set.swapfile = false
set.autoread = true

vim.g.zig_fmt_autosave = 0  
vim.g.go_fmt_autosave = 0-- disable that stupid zig fmt call after saving
