--
-- @file plugins.lua
-- @content  Configuration for "packer.nvim" package manager
--

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
	"git",
	"clone",
	"--depth",
	"1",
	"https://github.com/wbthomason/packer.nvim",
	install_path
    })
    print("Installing packer close and reopen NeoVim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Packer is not installed")
    return
end

-- Have packer use a popup window
packer.init({
    display = {
	open_fn = function()
	    return require("packer.util").float({ border = "rounded" })
    end,
    },
})


packer.startup(function(use)
    -- packer can manage itself!
    use "wbthomason/packer.nvim"

    -- color schemes
    use "Mofiqul/vscode.nvim"
    use "catppuccin/nvim"
    use "folke/tokyonight.nvim"
    use 'rebelot/kanagawa.nvim'
    -- nvim-tree
    use "nvim-tree/nvim-tree.lua"
    use "nvim-tree/nvim-web-devicons"

    -- lualine
    use "nvim-lualine/lualine.nvim"

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'xiyaowong/telescope-emoji.nvim'
    use 'dhruvmanila/telescope-bookmarks.nvim'
    use 'LinArcX/telescope-command-palette.nvim'
    --use 'dhruvmanila/browser-bookmarks.nvim'

    -- Language Server Protocol
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    -- go support
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'

    --rust support
    use 'mfussenegger/nvim-dap'
    use 'mrcjkb/rustaceanvim'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'

    -- undotree
    use 'mbbill/undotree'

    -- terminal
    use 'akinsho/toggleterm.nvim'

    -- bufferline
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        require = 'nvim-tree/nvim-web-devicons'
    }

    -- autopair
    use 'windwp/nvim-autopairs'

    -- vim be good
    use 'ThePrimeagen/vim-be-good'

    -- lisp
    use 'vlime/vlime'

    -- transparent bg
--    use 'xiyaowong/transparent.nvim'
end)
