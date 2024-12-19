return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    lazy = false,
    config = function()
      require('refactoring').setup {
        prompt_func_return_type = {
          -- go = false,
          -- java = false,
          --
          -- cpp = false,
          -- c = false,
          -- h = false,
          -- hpp = false,
          -- cxx = false,
        },
        prompt_func_param_type = {
          -- go = false,
          -- java = false,
          --
          -- cpp = false,
          -- c = false,
          -- h = false,
          -- hpp = false,
          -- cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
        show_success_message = false,
      }

      vim.keymap.set({ 'n', 'x' }, '<leader>R', function()
        require('refactoring').select_refactor()
      end, { desc = 'Refactoring' })
    end,
  },
}
