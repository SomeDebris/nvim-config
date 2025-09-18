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
-- Code for environment snippet in the above GIF
    s({
            trig="env", 
            dscr="Inserts a generic environment.",
            snippetType="autosnippet"
        },
        fmta(
            [[
                \begin{<>}
                  <>
                \end{<>}
            ]],
            {
                i(1),
                i(2),
                rep(1), -- this node repeats insert node i(1)
            }
        ),
        {condition = line_begin}
    ),
    
    s({trig="\\enum", dscr="Inserts a new enumeration enviroment",snippetType="autosnippet"},
        fmta(
            [[
                \begin{enumerate}
                  <>
                \end{enumerate}
            ]],
            { i(1) }
        ),
        {condition=line_begin}
    ),

    s({trig="\\figure", dscr="Inserts a new enumeration enviroment",snippetType="autosnippet"},
        fmta(
            [[
                \begin{figure}
                  <>
                \end{figure}
            ]],
            { i(1) }
        ),
        {condition=line_begin}
    ),

    s({trig="\\table", dscr="Inserts a new enumeration enviroment",snippetType="autosnippet"},
        fmta(
            [[
                \begin{table}
                  \centering
                  \begin{tabular}{<>}
                  \toprule
                  <>
                  \bottomrule
                  \end{tabular}
                  \caption{}
                  \label{}
                \end{table}
            ]],
            { i(1), i(2) }
        ),
        {condition=line_begin}
    ),
}
