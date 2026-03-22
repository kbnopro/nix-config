local utils = ls_tracked_dopackage("snippets.utils")

local snippet = {}

local autosnippet = {
  s(
    {
      dscr = "Inline math environment",
      regTrig = true,
      wordTrig = true,
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
