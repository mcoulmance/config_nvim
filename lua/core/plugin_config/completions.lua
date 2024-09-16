--
-- @file plugin_config/completions.lua
-- @content  Configuration for autocompletion and snippets (nvim-cmp, LuaSnip)
--
local status_cmp, cmp = pcall(require, 'cmp')
local status_snip, snip = pcall(require, 'luasnip')
local utils = require("core.plugin_config.lsputils")

if not status_cmp then
    print('Plugin "cmp" not found...')
    return
end

if not status_snip then
    print('Plugin "luasnip" not found...')
    return
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            snip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        },
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<ESC>'] = cmp.mapping.abort(),
        ['<C-o>'] = cmp.mapping.complete(),
        ['<CR>' ] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<Down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif snip.expand_or_jumpable() then
                snip.expand_or_jump()
            --elseif has_words_before() then
            --    cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif snip.jumpable(-1) then
                snip.jump(-1)
            else
                fallback()
            end
        end, { "i", "n" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip'  },
        { name = 'buffer'   },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path'     },
        { name = 'nvim_lua' },
        option = {
            get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
            end
        }
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = utils.get_cmp_kinds()[vim_item.kind] or ""
            vim_item.menu = ({
                buffer = "🅱",
                nvim_lsp = utils.get_lsp_symbol(),
                luasnip = "㊊"
            })[entry.source.name]
            return vim_item
        end,
    },
})
