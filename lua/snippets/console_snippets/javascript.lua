local create_snippet = require("snippets.create_printing_snippet")

local query = [[
(function_declaration (identifier) @name (#set! "fetch_last" "true"))
(field_definition (property_identifier) @name (arrow_function) (#set! "fetch_last" "true"))
(function_declaration (identifier) @name)
(variable_declarator (identifier) @name (function_expression) (#set! "fetch_last" "true"))
(variable_declarator (identifier) @name (arrow_function) (#set! "fetch_last" "true"))
(variable_declarator (identifier) @name (parenthesized_expression) (#set! "fetch_last" "true"))
(method_definition (private_property_identifier) @name)
(method_definition (property_identifier) @name)
]]

local breakpoints = {
	"field_definition",
	"function_declaration",
	"variable_declarator",
	"method_definition",
}

local format = [[console.log("[{function_name}]", {var})]]

local snippet = create_snippet({
	language = "javascript",
	format = format,
	query = query,
	breakpoints = breakpoints,
	program_node_name = "program",
})

return snippet
