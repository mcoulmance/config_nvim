--
-- @file plugin_config/lsputils.lua
-- @content  Some useful features for configuring LSs and Parsers
--

local M = {}

local general = "general"
local ocamllsp = "ocamllsp"
local lualsp = "lua_ls"

local State = { current_lsp_name = "" }

M.OCAML_LSP_NAME = (function() return ocamllsp end)()
M.LUA_LSP_NAME = (function() return lualsp end)()
M.GENERAL_NAME = (function() return general end)()

M.get_current_lsp_name = function()
    return State.current_lsp_name
end

M.set_current_lsp_name = function(lspname)
    State.current_lsp_name = lspname
end


local function spread(template)
    local result = {}
    for key, value in pairs(template) do 
        result[key] = value
    end

    return function(table)
        for key, value in pairs(table) do 
            result[key] = value
        end 
        return result 
    end 
end

M.get_cmp_kinds = function()
    local cmp_kinds = {
        ["common"] = {
            Text = "",
            Keyword = "",
            Snippet = "﬌",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
            Unit = "",
        },
        [M.GENERAL_NAME] = {
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "",
            Value = "",
            Enum = "",
        },
        [M.OCAML_LSP_NAME] = {
            Method = "ﬦ",
            Function = "ﬦ",
            Constructor = "ﬦ",
            Field = "ﬦ",
            Variable = "ﬦ",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﬦ",
            Value = "ﬦ",
            Enum = "ﬦ",
        },
    }
    local key = M.get_current_lsp_name()
    if key == "" then key = M.GENERAL_NAME end 
    local k = cmp_kinds[key];
    if k == nil then k = cmp_kinds.general end 
    return spread(k)(cmp_kinds.common)
end

M.get_lsp_symbol = function()
    if M.get_current_lsp_name() == M.OCAML_LSP_NAME then 
        return "🐫"
    else 
        return "𝕷" 
    end
end 

return M
