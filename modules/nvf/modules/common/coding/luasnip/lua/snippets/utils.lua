---@diagnostic disable: undefined-global

local utils = {}

function utils.v(pos, placeholder)
  return d(pos, function(_, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
      return sn(nil, { t(parent.snippet.env.LS_SELECT_RAW) })
    else -- If LS_SELECT_RAW is empty, return a blank insert node
      return sn(nil, i(1, placeholder or ""))
    end
  end)
end

function utils.vi(pos, placeholder)
  return d(pos, function(_, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
      return sn(nil, { t(parent.snippet.env.LS_SELECT_RAW), i(1) })
    else -- If LS_SELECT_RAW is empty, return a blank insert node
      return sn(nil, i(1, placeholder or ""))
    end
  end)
end

function utils.c(pos, handler)
  return f(function(_, snip)
    handler = handler or function(str)
      return str
    end
    return handler(snip.captures[pos])
  end)
end

utils.line_begin = require("luasnip.extras.expand_conditions").line_begin

utils.line_end = require("luasnip.extras.expand_conditions").line_end

utils.has_selected_text = require("luasnip.extras.expand_conditions").has_selected_text

return utils
