return {
  {
    'echasnovski/mini.comment',
    version = '*',
    config = function()
      require('mini.comment').setup {
        options = {
          ignore_blank_line = false,
          start_of_line = false,
          pad_comment_parts = true,
        },
        mappings = {
          comment = 'gc',
          comment_line = 'gcc',
          comment_visual = 'gc',
          textobject = 'gc',
        },
        hooks = {
          pre = function() end,
          post = function() end,
        },
      }
    end,
  },
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup {
        mappings = {
          left = '<C-h>',
          right = '<C-l>',
          down = '<C-j>',
          up = '<C-k>',
          line_left = '<S-h>',
          line_right = '<S-l>',
          line_down = '<S-j>',
          line_up = '<S-k>',
        },
        options = {
          reindent_linewise = true,
        },
      }
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    config = function()
      require('mini.indentscope').setup {
        draw = {
          delay = 50,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        mappings = {
          object_scope = 'ii',
          object_scope_with_border = 'ai',

          goto_top = '[i',
          goto_bottom = ']i',
        },
        options = {
          border = 'both',
          indent_at_cursor = true,
          try_as_border = false,
        },
        symbol = '╎',
      }
    end,
  },
}
