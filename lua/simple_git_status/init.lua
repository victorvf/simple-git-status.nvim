local M = {}


M.config = {
    mappings = {
        git_status = "<leader>gs",
    },
    setup_mappings = true,
}


local function get_by_dir(dir_path, status)
    local handle = io.popen(
        "git ls-files --others --full-name " .. dir_path .. " 2>/dev/null"
    )
    if not handle then return {} end

    local files = {}

    for file in handle:lines() do
        table.insert(files, { file = file, status = status })
    end

    handle:close()

    if #files == 0 then
        handle = io.popen(
            "git ls-files --full-name " .. dir_path .. " 2>/dev/null"
        )

        if handle then
            for file in handle:lines() do
                table.insert(files, { file = file, status = status })
            end

            handle:close()
        end
    end

    return files
end


local function get_git_files()
    local handle = io.popen("git status --porcelain")
    if not handle then return {} end

    local files = {}

    for line in handle:lines() do
        local status, file = line:match("^(..)%s(.+)$")

        if status and file then
            if file:sub(-1) == "/" then
                local dir_files = get_by_dir(file, status)

                for _, dir_file in ipairs(dir_files) do
                    table.insert(files, dir_file)
                end
            else
                table.insert(files, { file = file, status = status })
            end
        end
    end

    handle:close()

    return files
end


function M.git_status()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local sorters = require("telescope.sorters")
  local conf = require("telescope.config").values

  local files = get_git_files()

  if #files == 0 then
    print("No changes found")
    return
  end

  pickers.new({}, {
    prompt_title = "Git Status Files",
    finder = finders.new_table({
      results = files,
      entry_maker = function(entry)
        return {
          value = entry.file,
          ordinal = entry.file,
          display = entry.status .. " " .. entry.file,
          path = entry.file,
        }
      end
    }),
    sorter = conf.generic_sorter({}),
    previewer = conf.file_previewer({}),
  }):find()
end


function M.setup(opts)
    opts = opts or {}
    M.config = vim.tbl_deep_extend("force", M.config, opts)

    if M.config.setup_mappings then
        if M.config.mappings.git_status then
            vim.api.nvim_set_keymap(
                "n",
                M.config.mappings.git_status,
                "<cmd>lua require('simple_git_status').git_status()<CR>",
                { noremap = true, silent = true }
            )
        end
    end
end


return M
