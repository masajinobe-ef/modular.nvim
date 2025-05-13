local function load_plugins()
  local plugins = {}
  local categories = { 'util', 'ui', 'syntax', 'lsp', 'comp', 'lint', 'format' }

  for _, category in ipairs(categories) do
    local plugins_dir = vim.fn.stdpath 'config'
      .. '/lua/modular/plugins/'
      .. category
    local ok, files = pcall(vim.fn.readdir, plugins_dir)
    if not ok then
      goto continue
    end

    for _, file in ipairs(files) do
      if file:sub(-4) == '.lua' then
        local plugin_name = file:sub(1, -5)
        local plugin_path = 'modular/plugins/' .. category .. '/' .. plugin_name
        local fine, plugin = pcall(require, plugin_path)
        if fine then
          table.insert(plugins, plugin)
        end
      end
    end
    ::continue::
  end

  return plugins
end

require('lazy').setup(load_plugins(), {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
