-- Create lua snippet creating context of ReactJS

local luasnip = require("luasnip")
local i = luasnip.insert_node
local c = luasnip.choice_node
local t = luasnip.text_node
local sn = luasnip.snippet
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local react_boilerplate = sn(
	"ContextBoi",
	fmt(
		[[
  import React, {{ createContext }} from 'react';
  import PropTypes from 'prop-types';

  {js_doc}
  export const {context_name}Context{ts_type} = createContext();
  
  const {context_name}Provider = ({{ children }}) => {{
    {}/* Your code goes here */
    return <{context_name}Context.Provider values={{{{}}}}>{{children}}</{context_name}Context.Provider>;
  }};

  {context_name}Provider.propTypes = {{
    children: PropTypes.node.isRequired,
  }};

  {export_method};
]],
		{
			js_doc = d(1, function(args)
				local component_name = args[1][1]
				local is_file_typescript = string.find(vim.bo.filetype, "typescript")
				if is_file_typescript then
					return s(nil, t({ "type " .. component_name .. "ContextProps = {}", "" }))
				end
				return s(
					nil,
					t({
						"/**",
						" * @typedef {Object} props",
						" * @property {}",
						" */",
						"/**",
						" * @type { React.Context<props> }",
						" */",
					})
				)
			end, { 3 }),
			ts_type = d(2, function(args)
				local component_name = args[1][1]
				local is_file_typescript = string.find(vim.bo.filetype, "typescript")
				if not is_file_typescript then
					return s(nil, t(""))
				end
				return s(nil, t(": React.Context<" .. component_name .. "ContextProps>"))
			end, { 3 }),
			context_name = i(3, "Context"),
			export_method = d(4, function(args)
				local component_name = args[1][1]
				return s(nil, {
					c(1, {
						i(1, "export default " .. component_name .. "Provider"),
						i(2, "export { " .. component_name .. "Provider }"),
					}),
				})
			end, { 3 }),
			i(0),
		},
		{
			repeat_duplicates = true,
		}
	)
)

return react_boilerplate
