local M = {
  api = {
    env_path = ".aidos-env",
    model = "codestral-2508",
    url = "http://localhost:1234/api/",
    debug = false,
  },
  prompts = {
    --- Default prompt for code completion
    code_completion_prompt = [[
    Complete the following code snippet/function/class outline.
    Respond only with the code, without any additional remarks, explanations, or comments outside the code block.
    Store the pure code under the key "code" in the output json.

    ======

    ]],
    docstring_completion_prompt = [[
    Add languag appropriate docstrings and types to the following code snippet/function/class outline.
    Respond only with the new annotated and documentedd code, without any additional remarks, explanations, or comments outside the code block.
    Store the pure code under the key "code" in the output json. Write comments and docstrings always in English.

    ======

    ]]

  }
}


return M
