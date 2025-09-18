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
    -- s({
    --         trig="\\frac", 
    --         dscr="Inserts a dialogue entry", 
    --         snippetType="autosnippet"
    --     },
    --     fmta(
    --         [[
    --             \frac{<>}{<>}
    --         ]],
    --         { 
    --             i(1),
    --             i(2),
    --         }
    --     )
    -- ),
    s({trig="\\equ", dscr="Inserts an Equation",snippetType="autosnippet"},
        fmta(
            [[
                \begin{equation}
                  <>
                \end{equation}
            ]],
            { i(0) }
        ),
        {condition=line_begin}
    ),

    s({trig="\\ali", dscr="Inserts an alignment",snippetType="autosnippet"},
        fmta(
            [[
                \begin{align*}
                  <>
                \end{align*}
            ]],
            { i(0) }
        ),
        {condition=line_begin}
    ),
    
    s({trig="\\sect", dscr="Inserts a new section",snippetType="autosnippet"},
        fmta(
            [[
            \section{<>}
            ]],
            { i(1) }
        ),
        {condition=line_begin}
    ),


-- intslug
}
