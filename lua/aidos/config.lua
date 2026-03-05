local M = {
  env_path = ".aidos-env",
  model = "codestral-2508",
  url = "http://localhost:1234/api/",
  debug = false,
  --- Default prompt for code completion
  code_completion_prompt = [[
    Complete the following code snippet/function/class outline.
    Respond only with the code, without any additional remarks, explanations, or comments outside the code block.
    Store the pure code under the key "code" in the output json.

    ======

  ]]
}


return M
