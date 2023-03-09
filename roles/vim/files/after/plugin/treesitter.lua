require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = {
    -- phpdoc TS parser compilation is broken on M1 Macs and other ARM64
    'phpdoc'
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = false
  },
  context = {
    enable = true,
    patterns = {
      default = {
        'class',
        'function',
        'if',
        'for',
        'switch',
        'case',
      }
    }
  },
  context_commentstring = {
    enable = true,
  },
  rainbow = {
    query = {
      'rainbow-parens',
      html = 'rainbow-tags'
    },
    strategy = {
      require('ts-rainbow').strategy.global,
    },
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ia'] = '@parameter.inner',
      }
    },
    swap = {
      enable = true,
      swap_previous = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_next = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
        [']a'] = '@parameter.inner',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']C'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
        ['[a'] = '@parameter.inner',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[C'] = '@class.outer',
      },
    },
  }
}

vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
