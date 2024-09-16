--
-- @file functions.lua
-- @content  Utilities functions for NVim
--

-- set the tab level
-- parameters are obtional, if not provided default to 4
function tab(tabstop, shiftwidth)
    if not tabstop then
        tabstop = 4
    end

    if not shiftwidth then
        shiftwidth = 4
    end

    vim.opt.tabstop = tabstop
    vim.opt.shiftwidth = shiftwidth
end

function gnutab()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
end

-- changes the editor's color scheme
-- parameter is optional, if not provided default to "vscode"
function color(scheme)
    if not scheme then
        scheme = "vscode"
    end

    local status, _ = pcall(vim.cmd, "colorscheme " .. scheme)
    if not status then
        print("Could not load colorscheme " .. scheme)
    end
end
