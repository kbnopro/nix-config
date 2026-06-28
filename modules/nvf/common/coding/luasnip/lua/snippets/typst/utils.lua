---@diagnostic disable: undefined-global

local make_condition = require("luasnip.extras.conditions").make_condition

local utils = {}

-- Typst has three type of environments and the corresponding tree-sitter nodes:
-- Code: "code"
-- Math: "math"
-- Text: "content" | "text" sometimes "text" does not include whitespace, so we also check for "content"
local function current_mode()
	local node = vim.treesitter.get_node()

	-- Traverse up the tree until we find a node that matches one of the environment types
	while node do
		local node_type = node:type()
		if node_type == "code" then
			return "code"
		elseif node_type == "math" then
			return "math"
		elseif node_type == "content" then
			return "text"
		end
		node = node:parent()
	end

	return "text"
end

utils.in_math = make_condition(function()
	return current_mode() == "math"
end)
utils.in_code = make_condition(function()
	return current_mode() == "code"
end)
utils.in_text = make_condition(function()
	return current_mode() == "text"
end)

return utils
