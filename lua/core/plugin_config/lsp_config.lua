--
-- @file plugin_config/lsp_config.lu
-- @content  Configuration for LSP's plugin (mason, mason-lsp-config and nvim-lsp-config)
--

local status_mason, mason = pcall(require, "mason")
local status_masonlsp, mason_lsp = pcall(require, "mason-lspconfig")
local status_lspconfig, lspconfig = pcall(require, "lspconfig")
local utils = require("core.plugin_config.lsputils")

if not status_mason then
    print('Plugin "mason" not found...')
    return
end

if not status_masonlsp then
    print('Plugin"mason-lspconfig" not found...')
    return
end

if not status_lspconfig then
    print('Plugin "lspconfig" not found...')
    return
end

local c = vim.lsp.protocol.make_client_capabilities()
c.textDocument.completion.completionItem.snippetSupport = true
c.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(c)

local on_attach = function(client, bufnr)
    utils.set_current_lsp_name(client.name)
--    print('Starting LSP'..vim.inspect(client))
  --[[
    local codelens = vim.api.nvim_create_augroup(
        'LSPCodeLens',
        { clear = true }
    )
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
        group = codelens,
        callback = vim.lsp.codelens.refresh,
        buffer = bufnr,
    })
]]
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, bufopts)

    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, bufopts)


    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
    end
end
--[[
local on_attach_without_codelens = function(client, bufnr)
    utils.set_current_lsp_name(client.name)
--[[
    local codelens = vim.api.nvim_create_augroup(
        'LSPCodeLens',
        { clear = true }
    )
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
        group = codelens,
        callback = vim.lsp.codelens.refresh,
        buffer = bufnr,
    })

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, bufopts)

    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, bufopts)


    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
    end
end
]]




mason.setup()

mason_lsp.setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
       -- "ocamllsp",
        "neocmake",
        "clangd",
        "pylsp",
        "ltex",
        "bashls",
        "elp",
        "swift_mesonls",
        "zls",
        "tsserver",
        "perlnavigator",
        "clojure_lsp",
        "serve_d"
    },
})

lspconfig.lua_ls.setup({
    on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,

    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.ocamllsp.setup({
    cmd = { "ocamllsp", "--fallback-read-dot-merlin" },
    name = utils.OCAML_LSP_NAME,
    settings = {
        codelens = { enable = true },
    },
    filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
    root_dir = lspconfig.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.hls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    single_file_support = true,
})
--[[
lspconfig.ccls.setup({
    init_options = {
        compilationDatabaseDirectory = "build",
        index = {
            threads = 0,
        },
        clang = {
            excludeArgs = { "-frounding-math" },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})]]

lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

--[[
vim.tbl_deep_extend('keep', lspconfig, {
  lsp_name = {
    cmd = { 'c3-lsp' },
    filetypes = { 'c3', 'c3i', 'c3t' },
    name = 'c3_lsp',
  }
})

lspconfig.c3_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
]]

lspconfig.asm_lsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'W391'},
                    maxLineLength = 100
                }
            }
        }
    },
    on_attach = on_attach,
    capabilities = capabilities,
})
-- don't do this here, causes conflicts with rustaceanvim
--[[
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities
})
]]

lspconfig.ltex.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    use_spellfile = false,
    filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
    settings = {
        ltex = {
            enabled = { "latex", "tex", "bib", "markdown" },
            language = "auto",
            diagnosticSeverity = "information",
            sentenceCacheSize = 2000,
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "fr",
            },
            disabledRules = {
                fr = { "APOS_TYP", "FRENCH_WHITESPACE" }
            },
            dictionary = (function()
                -- For dictionary, search for files in the runtime to have
                -- and include them as externals the format for them is
                -- dict/{LANG}.txt
                --
                -- Also add dict/default.txt to all of them)
                local files = {}
                for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
                    local lang = vim.fn.fnamemodify(file, ":t:r")
                    local fullpath = vim.fs.normalize(file, ":p")
                    files[lang] = { ":" .. fullpath }
                end

                if files.default then
                    for lang, _ in pairs(files) do
                        if lang ~= "default" then
                            vim.list_extend(files[lang], files.default)
                        end
                    end
                    files.default = nil
                end
                return files
            end)(),
        }
    }
})

lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.elp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

--[[lspconfig.cmakelang.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})]]

lspconfig.neocmake.setup({
    cmd = { "neocmakelsp", "--stdio" },
    filetypes = { "cmake" },
    single_file_support = true,
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        format = {
            enable = true,
        },
        scan_cmake_in_package = true,
    }
})

lspconfig.vala_ls.setup({
    on_attatch = on_attach,
    capabilities = capabilities,
})

lspconfig.swift_mesonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.zls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.perlnavigator.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.clojure_lsp.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

lspconfig.serve_d.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.elixirls.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

-- Diagnostic symbols in the sign column (gutter)
local signs = {
  Error = " ",
  Warn = " ",
  Info = " ",
  Hint = " "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●"
  },
  signs = true,
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded" }
)

vim.cmd [[
    " make hover window"s background transparent
    highlight! link FloatBorder Normal
    highlight! link NormalFloat Normal
]]
