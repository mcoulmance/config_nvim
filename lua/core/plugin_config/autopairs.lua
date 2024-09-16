--
-- @file: plugin_config/autopairs.lua
-- @content: Configuration for the "autopairs" plugin
--

local status, npairs = pcall(require, "nvim-autopairs")

if not status then
    print('Plugin "nvim-autopairs" not found...')
    return
end

local cond = require 'nvim-autopairs.conds'
local Rule = require 'nvim-autopairs.rule'

npairs.setup {
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel", "ocaml" },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"'} ,-- "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
    },
}

npairs.add_rules({
    Rule("'", "'", "ocaml")
        -- don't add a pair if next character is alphanumeric
        :with_pair(cond.not_after_regex("[%w%]."))
        -- and if previous character is ':' (OCaml's polymorphic type)
        :with_pair(cond.not_before_regex(":"))
})

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    print("cmp not found")
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
