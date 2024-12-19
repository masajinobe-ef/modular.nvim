return {
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },

    vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<CR>', {
      noremap = true,
      silent = true,
      desc = 'Telescope: ToDo Comments',
    }),
  },
}
