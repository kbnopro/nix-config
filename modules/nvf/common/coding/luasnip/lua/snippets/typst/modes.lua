local utils = ls_tracked_dopackage("snippets.utils")
local typst_utils = ls_tracked_dopackage("snippets.typst.utils")

local snippet = {}

local autosnippet = {
	s(
		{
			dscr = "Inline math environment",
			regTrig = true,
			wordTrig = true,
			condition = -typst_utils.in_math,
			trig = "mm",
		},
		fmta(
			[[
        $<>$
      ]],
			{
				utils.v(1),
			}
		)
	),
	s(
		{
			dscr = "Display math environment",
			regTrig = true,
			wordTrig = true,
			condition = -typst_utils.in_math,
			trig = "dm",
		},
		fmta(
			[[
        $
          <>
        $
        <>
      ]],
			{
				utils.v(1),
				i(0),
			}
		)
	),
}

return snippet, autosnippet
