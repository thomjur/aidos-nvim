local M = {}

local aidos_config = require("aidos.config")

-- Display current config
function M.display_config()
  print(vim.inspect(aidos_config))
end

--- Return the currently highlighted lines plus the starting and final line numbers.
---  @return string|nil   The currently highlighted lines or nil if nothing was highlighted.
---  @return int          The starting line of the selected text.
---  @return int          The final line of the selected text.
function M.get_highlighted_lines()
  -- Exit visual mode to make sure that markers are set
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", true)

  -- Get line numbers of visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] -- 1-based line number
  local end_line = end_pos[2]     -- 1-based line number

  local saved_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- DEBUG
  if aidos_config.debug then
    print("[DEBUG] " .. vim.inspect(saved_lines))
  end

  -- Return lines or nil if table is empty
  if #saved_lines == 0 then
    return nil, nil, nil
  end

  return table.concat(saved_lines, "\n"), start_line - 1, end_line
end

-- Function to read and parse a .env file. The key must be API_KEY in the .env file.
--- @param file_path string The path to the .env file
--- @return string The API KEY found in the .env file
function M.parse_api_key_from_env_file(file_path)
  local api_key = ""
  local file = io.open(file_path, "r")
  if not file then
    vim.notify("Could not open .env file in " .. file_path, vim.log.levels.ERROR)
    return ""
  end

  for line in file:lines() do
    -- Skip empty lines and comments (lines starting with #)
    if line:match("^%s*#") or line:match("^%s*$") then
      goto continue
    end

    -- Split the line into key and value
    local key, value = line:match("^%s*([%w_]+)%s*=%s*(.+)%s*$")
    if key == "AIDOS_API_KEY" and value then
      -- Remove surrounding quotes if present
      value = value:gsub("^['\"](.*)['\"]$", "%1")
      api_key = value
    end

    ::continue::
  end

  file:close()
  return api_key
end

return M
