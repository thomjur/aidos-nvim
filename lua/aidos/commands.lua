local M = {}

local utility_functions = require("aidos.utils")

function M.setup()
  vim.api.nvim_create_user_command('AidosConfig', utility_functions.display_config,
    { desc = "Show current user config." })
end

return M
