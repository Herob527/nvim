local luasnip = require("luasnip")
local i = luasnip.insert_node
local sn = luasnip.snippet
local t = luasnip.text_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local ts = vim.treesitter

local ts_query = ts.query

---
--- @class param
--- @field format string -- format string, should contain {function_name} and {var}.
--- @field query string - treesitter query for fetching function name
--- @field breakpoints string[] - breakpoints for treesitter when it should check nearest function name in scope
--- @field parser_name string | nil - default: `language param` - optional treesitter parser name. Exists due to crashes for jsx and tsx files.
--- @field program_node_name string - treesitter node name of program (ex. for JS - "program", for Lua - "chunk")
--- @field trigger string | nil - default: "con" -trigger name of snippet
--- @field enforce_old_parser boolean | nil - default: false - enforce use old node get
--- @field language string

--- Function for creating printing snippet for luasnip
--- In idea, snippet prints printing function for language with name of function in the nearest scope
--- @param param param
local create_printing_snippet = function(param)
  local function all_trim(str)
    return str:match("^%s*(.-)%s*$")
  end
  --- @param node TSNode | nil
  --- @param ts_elements table<string>
  local function seek_function_root(node, ts_elements)
    if node == nil then
      return nil
    end
    local node_type = node:type()
    if vim.tbl_contains(ts_elements, node_type) or node_type == param.program_node_name then
      return node
    end

    local parent = node:parent()

    return seek_function_root(parent, ts_elements)
  end

  --- @param node TSNode | nil
  local function get_node_text(node)
    if node == nil then
      return nil
    end
    local node_type = node:type()
    if node_type == param.program_node_name then
      return "global"
    end
    local parsed_query = ts_query.parse(param.parser_name or param.language, param.query)
    local capture_amount = #parsed_query.captures
    local captures = parsed_query:iter_captures(node, 0, node:start(), node:end_())
    local final_text = ""

    local query_data = {}
    local query_metadata = {}
    for _, parsed_node, metadata in captures do
      local text = ts.get_node_text(parsed_node, 0)
      for key, val in pairs(metadata) do
        query_metadata[key] = val
      end
      if text == nil then
        return
      end
      table.insert(query_data, { ["text"] = text })
    end

    for index, value in ipairs(query_data) do
      if query_metadata.fetch_last == "true" and index == capture_amount then
        return value.text
      end

      final_text = capture_amount + 1 == index and (value.text .. " - " .. final_text) or value.text
    end
    return final_text
  end

  --- Since nvim 0.10.0, tsx and jsx files are properly handled
  local function get_node(snip)
    local current_version = vim.version()
    local current_version_table = { current_version.major, current_version.minor, current_version.patch }
    local version_with_fixed_tsx = { 0, 10, 0 }
    local is_current_version_fixed_tsx = vim.version.cmp(current_version_table, version_with_fixed_tsx) >= 0
    if is_current_version_fixed_tsx and not param.enforce_old_parser then
      return ts:get_node()
    else
      local pos_begin = snip.nodes[1].mark:pos_begin()
      local pos_end = snip.nodes[1].mark:pos_end()
      local parser = vim.treesitter.get_parser(0, param.parser_name or param.language)
      local tstree = parser:parse()

      return tstree[1]:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])
    end
  end

  --- @param str string | nil
  local function normalize(str)
    return str and str:gsub("\"", "\\\"") or str
  end

  local console = sn(
    param.trigger or "con",
    fmt(param.format, {
      function_name = d(1, function(args, snip)
        local ts_node = get_node(snip)
        local checked_value = all_trim(args[1][1])
        local function_root = seek_function_root(ts_node, param.breakpoints)
        local data = function_root ~= nil and get_node_text(function_root) or ""
        local output = checked_value ~= "" and t(normalize(data .. " - " .. checked_value)) or t(normalize(data))
        return s(nil, { output })
      end, { 2 }),
      var = i(2),
    })
  )
  return console
end

return create_printing_snippet
