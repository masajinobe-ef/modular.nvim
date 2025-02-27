return {
  -- {
  --   'echasnovski/mini.comment',
  --   version = '*',
  --   config = function()
  --     require('mini.comment').setup {
  --       options = {
  --         ignore_blank_line = false,
  --         start_of_line = false,
  --         pad_comment_parts = true,
  --       },
  --       mappings = {
  --         -- Toggle comment (like `gcip` - comment inner paragraph) for both
  --         -- Normal and Visual modes
  --         comment = 'gc',
  --
  --         -- Toggle comment on current line
  --         comment_line = 'gcc',
  --
  --         -- Toggle comment on visual selection
  --         comment_visual = 'gc',
  --
  --         -- Define 'comment' textobject (like `dgc` - delete whole comment block)
  --         -- Works also in Visual mode if mapping differs from `comment_visual`
  --         textobject = 'gc',
  --       },
  --       hooks = {
  --         pre = function() end,
  --         post = function() end,
  --       },
  --     }
  --   end,
  -- },
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
