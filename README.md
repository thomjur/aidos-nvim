# AIdos: Neovim Plugin for LLM-Powered Code Completion

**LLM Integration for Code Completion and Documentation in Neovim**

---

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Using Lazy.nvim](#using-lazy-nvim)
- [Configuration](#configuration)
  - [API Settings](#api-settings)
  - [Keymaps](#keymaps)
  - [Commands](#commands)
- [Usage](#usage)
  - [Code Completion](#code-completion)
  - [Docstring Completion](#docstring-completion)
  - [Utility Functions](#utility-functions)
- [Contributing](#contributing)
- [License](#license)
- [File Structure](#file-structure)
- [Versions](#versions)

---

## Introduction

**AIdos** is a Neovim plugin designed to integrate Large Language Models (LLMs) directly into your editor. It provides intelligent code completion and docstring generation, enhancing your coding workflow with context-aware suggestions and automated documentation.

---

## Features

- **Code Completion**: Get intelligent, context-aware code suggestions powered by LLMs.
- **Docstring Completion**: Automatically add language-appropriate docstrings and type annotations to your functions and classes.
- **Customizable**: Configure API endpoints, models, and prompts to fit your needs.
- **Debug Mode**: Enable verbose logging for troubleshooting.

---

## Installation

### Prerequisites

- Neovim 0.11.0 or later
- A `.env` file with your LLM API key (e.g., `AIDOS_API_KEY=your-key-here`)

### Using Lazy.nvim

Add this to your plugin spec:

```lua
{
  'thomjur/aidos-nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = true,
}
```

---

## Configuration

### API Settings

Configure your LLM provider in your Neovim config:

```lua
require('aidos').setup(
    api = {
        url = 'http://localhost:1234/api/', -- Default API endpoint
        env_path = '.aidos-env', -- Path to local env file with API key stored under AIDOS_API_KEY
        model = 'codestral-2508', -- Default model
        debug = false, -- Enable for verbose logging
  }
)
```

### Keymaps

Aidos sets up default visual mode keymaps:

```lua
-- Code completion: <leader>ac in visual mode
vim.keymap.set('v', '<leader>ac', function() require('aidos.functions').send_code_completion_request('code') end, 
  { desc = 'Aidos: Complete Code' })

-- Docstring completion: <leader>ad in visual mode
vim.keymap.set('v', '<leader>ad', function() require('aidos.functions').send_code_completion_request('docstring') end,
  { desc = 'Aidos: Add Docstrings' })
```

### Commands

- `:AidosConfig`: Display the current configuration.

---

## Usage

### Code Completion

1. Visually select the code you want to complete.
2. Press `<leader>ac`.
3. The completion will be inserted below your cursor.

### Docstring Completion

1. Visually select the code you want to document.
2. Press `<leader>ad`.
3. The code with added docstrings and type annotations will be inserted below your cursor.

### Utility Functions

- **Display Config**: Run `:AidosConfig` to show your current settings.

---

## Contributing

Contributions are welcome! Open an issue or submit a pull request for bug fixes, new features, or improvements.

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

---

## License

Aidos is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## File Structure

- `lua/aidos/config.lua`: Default configuration and API settings.
- `lua/aidos/utils.lua`: Utility functions for parsing `.env` and handling errors.
- `lua/aidos/functions.lua`: Core completion logic and API interaction.
- `lua/aidos/keymaps.lua`: Default keymaps.
- `lua/aidos/commands.lua`: User commands (e.g., `:AidosConfig`).
- `lua/aidos/init.lua`: Plugin entry point and setup.

---

**Note**: Ensure your `.env` file is in your Neovim runtime path or specify the path in the setup.

## Versions

### 0.1 (05.03.2026)

- Initial commit

### 0.2 (Recent)

- Added docstring completion feature
- Restructured configuration system
- Added debug mode for verbose logging
- Updated default API endpoint to localhost
