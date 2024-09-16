--
-- @file     plugin_config/treesitter.lua
-- @content  Configuration for the treesitter plugin
--
-- A parser generator tool and an incremental parsing library. Builds
-- a concrete syntax tree for a source file.
--

local status, telescope = pcall(require, "nvim-treesitter.configs")

if not status then
    print('Plugin "treesitter" not found')
    return
end

telescope.setup({
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = { "ocaml" },
    },
    ensure_installed = {
        "bash",
        "ocaml",
        "rust",
        "lua",
        "c",
        "cpp",
        "tsx",
        "javascript",
        "typescript",
        "toml",
        "yaml",
        "css",
        "html",
        "zig",
        "c_sharp",
        "cmake",
        "commonlisp",
        "cuda",
        "doxygen",
        "dockerfile",
        "fortran",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "haskell",
        "html",
        "java",
        "json",
        "luadoc",
        "llvm",
        "make",
        "markdown",
        "markdown_inline",
        "menhir",
        "ninja",
        "ocaml_interface",
        "ocamllex",           -- TODO
        "odin",
        "pascal",
        "php",
        "python",
        "perl",
        "xml",
        "vimdoc",
    },
    sync_install = true,
    autotag = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    autopairs = {
        enable = true,
    }
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = 'org'
}

parser_config.c3 = {
  install_info = {
    url = "https://github.com/c3lang/tree-sitter-c3",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  }
}

vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3"
  }
})
