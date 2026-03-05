local M = {}
local fn = require("aidos.functions")

function M.setup()
  -- Call code completion
  vim.keymap.set("v", "<leader>ac", function() fn.send_code_completion_request("code") end,
    { desc = "Create a code completion prompt with the currently highlighted code." })
  -- Call docstring completion
  vim.keymap.set("v", "<leader>ad", function() fn.send_code_completion_request("docstring") end,
    { desc = "Create a docstring completion prompt with the currently highlighted code." })
end

return M
