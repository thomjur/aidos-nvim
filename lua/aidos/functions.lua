local M = {}
local config = require("aidos.config")
local utils = require("aidos.utils")

--- Function to create a prompt from user input
--- @return string|nil    The full completion prompt.
function M.create_code_completion_prompt()
  local highlighted_code = utils.get_highlighted_lines()
  if highlighted_code == nil or highlighted_code == "" then
    vim.notify("You must highlight some code first before using the code completion function!", vim.log.levels.WARN)
    return nil
  end
  local completion_prompt = config.code_completion_prompt .. highlighted_code
  if config.debug then
    print("[DEBUG] The current prompt is: \n" .. completion_prompt)
  end
  return completion_prompt
end

--- Function to send the prompt to the API endpoint and insert the response below the cursor
function M.send_code_completion_request()
  local prompt = M.create_code_completion_prompt()
  if not prompt then
    return
  end

  local api_endpoint = config.url
  if not api_endpoint then
    vim.notify("API endpoint is not defined in config!", vim.log.levels.ERROR)
    return
  end

  local api_key = config.api_key
  if not api_key then
    vim.notify("API key is not defined in config!", vim.log.levels.ERROR)
    return
  end

  -- Use vim.system to run curl command asynchronously
  vim.system({
    "curl",
    "-s", -- Silent mode to avoid printing progress
    "-X", "POST",
    "-H", "Content-Type: application/json",
    "-H", "Accept: application/json",
    "-H", "Authorization: Bearer " .. api_key,
    "-d", vim.json.encode({
    model = config.model,
    messages = {
      {
        role = "user",
        content = prompt
      }
    },
    response_format = { type = "json_object" }
  }),
    api_endpoint
  }, { text = true }, function(obj)
    -- Vim cannot run notify and others in async mode outside of main loop
    vim.schedule(function()
      if obj.code == 0 then
        -- Parse the JSON response
        local ok, response = pcall(vim.json.decode, obj.stdout)
        if ok and response and response.choices and response.choices[1] and response.choices[1].message then
          local content = response.choices[1].message.content
          -- Parse the response JSON with the cannotde
          local ok, code_response = pcall(vim.json.decode, content)
          if not ok then
            vim.notify("Failed to parse JSON code response: " .. content, vim.log.levels.ERROR)
            return
          end
          -- Create lines from code
          lines = vim.split(code_response["code"], "\n")
          -- Get the current cursor position
          local row = vim.api.nvim_win_get_cursor(0)[1]
          -- Insert the response content below the current line
          vim.api.nvim_buf_set_lines(0, row, row, false, lines)
        else
          vim.notify("Failed to parse JSON response: " .. obj.stdout, vim.log.levels.ERROR)
        end
      else
        vim.notify("Failed to get response from API: " .. obj.stderr, vim.log.levels.ERROR)
      end
    end)
  end)
end

return M
