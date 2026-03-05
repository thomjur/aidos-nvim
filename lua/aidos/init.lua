local M = {}

local default_config = require("aidos.config")
local utility_functions = require("aidos.utils")

--- Main setup function
function M.setup(opts)
  --- Loading commands
  require("aidos.commands").setup()
  -- Loading keymaps
  require("aidos.keymaps").setup()

  --- Adapting config using user defined parameters
  local merged = vim.tbl_deep_extend("force", default_config, opts or {})
  -- We need to override the values in the original
  for k, v in pairs(merged) do
    default_config[k] = v
  end
  -- Parse api key from env file
  local tmp_api_key = utility_functions.parse_api_key_from_env_file(default_config.env_path)
  if tmp_api_key == "" then
    vim.notify("Could not find an api key in .env file " ..
      default_config.env_path .. ". Is the key correctly stored under API_KEY=<API_KEY>?")
  end
  default_config["api_key"] = tmp_api_key
end

return M
