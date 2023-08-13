local create_snippet = require("snippets.create_printing_snippet")

local query = [[
(field_definition (property_identifier) @name)
(function_declaration (identifier) @name)
(variable_declarator (identifier) @name)
(method_definition (private_property_identifier) @name)
(method_definition (property_identifier) @name)
]]

local breakpoints = {
	"field_definition",
	"function_declaration",
	"variable_declarator",
	"method_definition",
}

local snippet = create_snippet("javascript", [[console.log("{function_name}","{var}")]], query, breakpoints)

return snippet
