local M = {}
local fn = require("aidos.functions")

function M.setup()
  vim.keymap.set("v", "<leader>ac", fn.send_code_completion_request,
    { desc = "Create a code completion prompt with the currently highlighted code." })
end

return M
