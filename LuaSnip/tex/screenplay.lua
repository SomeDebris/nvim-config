local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s({
            trig="\\dial", 
            dscr="Inserts a dialogue entry", 
            snippetType="autosnippet"
        },
        fmta(
            [[
                \begin{dialogue}{<>}
                  <>
                \end{dialogue}
            ]],
            { 
                i(1),
                i(2),
            }
        ),
        {condition = line_begin}
    ),

-- intslug
    s({
            trig="\\intsl",
            dscr="Inserts an intslug",
            snippetType="autosnippet",
        },
        fmta(
            [[
                \intslug[<>]{<>}
            ]],
            {
                i(0),
                i(1),
            }
        ),
        {condition = line_begin}
    ),

-- turn "vo" to (V.O.)
    s({trig="vo", dscr="expand vo to (V.O.)"},
        { t("(V.O.)") }
    ),
}
