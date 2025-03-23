## Simple Git Status

A Neovim plugin that leverages Telescope to display files from git status, providing a quick view of your current working files.

![Image](https://github.com/user-attachments/assets/9f2c6a51-0a25-4675-9906-cf8b8f580a79)


## Installation

### Requirements
- [Neovim](https://neovim.io/)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)


[Using packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'victorvf/simple-git-status.nvim',
  requires = {'nvim-telescope/telescope.nvim'}
}
```

[Using lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'victorvf/simple-git-status.nvim',
  dependencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('git_files').setup()
  end
}
```

[Using vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'nvim-telescope/telescope.nvim'
Plug 'vicorvf/simple-git-status.nvim'
```


## Usage

By default, the plugin maps:

- `<leader>gs` - Opens the Telescope picker with Git Status files

Select any file to open it, or use Telescope's standard features to preview, filter, and navigate through files.


## Configuration

The plugin works right out of the box, but you can customize it:

```lua
require('git_files').setup({
  -- Change default mappings
  mappings = {
    git_status = "<leader>gf", -- Change from <leader>gs to what you prefer
  },
  
  -- Completely disable default mappings
  setup_mappings = false, -- To set your own mappings
})
```

Setting up mappings manually

If you've disabled default mappings, you can set your own:

```lua
-- First disable default mappings
require('git_files').setup({
  setup_mappings = false
})

-- Then define your own mappings
vim.api.nvim_set_keymap('n', '<leader>gs', "<cmd>lua require('git_files').git_status()<CR>", { noremap = true })

-- Or
nnoremap <leader>gs <cmd>lua require('git_files').git_status()<CR>
```


## Contributing

Contributions are welcome! Feel free to open issues or pull requests to improve the plugin.


## License
[MIT](https://github.com/victorvf/simple-git-status.nvim/blob/main/LICENSE)

