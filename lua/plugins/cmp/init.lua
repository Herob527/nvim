local M = {}

local dictionary = {
  module = "blink-cmp-dictionary",
  name = "Dict",
  -- Make sure this is at least 2.
  -- 3 is recommended
  min_keyword_length = 3,
  --- @type blink-cmp-dictionary.Options
  opts = {
    dictionary_files = { vim.fn.expand("~/.config/nvim/dictionary/words.dict") },
    -- options for blink-cmp-dictionary
  },
  transform_items = function(_, items)
    for _, item in ipairs(items) do
      item.labelDetails = {
        description = "[DICT]",
      }
    end
    return items
  end,
}

local npm = {
  name = "npm",
  module = "blink-cmp-npm",
  async = true,
  -- the options below are optional
  ---@module "blink-cmp-npm"
  ---@type blink-cmp-npm.Options
  opts = {
    ignore = {},
    only_semantic_versions = true,
    only_latest_version = false,
  },

  transform_items = function(_, items)
    for _, item in ipairs(items) do
      item.labelDetails = {
        description = "[NPM]",
      }
    end
    return items
  end,
}
local ripgrep = {
  module = "blink-ripgrep",
  name = "Ripgrep",
  -- the options below are optional, some default values are shown
  ---@module "blink-ripgrep"
  ---@type blink-ripgrep.Options
  opts = {
    prefix_min_len = 3,
    context_size = 5,
    max_filesize = "1M",
    project_root_marker = ".git",
    project_root_fallback = true,
    search_casing = "--ignore-case",
    additional_rg_options = {},
    fallback_to_regex_highlighting = true,
    ignore_paths = {},
    additional_paths = {},
    toggles = {
      on_off = nil,
    },
    future_features = {
      backend = {
        use = "ripgrep",
      },
    },
    debug = false,
  },
  transform_items = function(_, items)
    for _, item in ipairs(items) do
      item.labelDetails = {
        description = "[RG]",
      }
    end
    return items
  end,
}

M.config = {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = { preset = "enter" },

    appearance = {

      highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰆦",
        Property = "󰖷",

        Class = "󱡠",
        Interface = "󱡠",
        Struct = "󱡠",
        Module = "󰅩",

        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        EnumMember = "󰦨",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
      },
    },
    signature = { enabled = true },
    completion = {
      list = { selection = { preselect = true, auto_insert = false } },
      -- ghost_text = {
      -- 	enabled = true,
      -- },
      menu = {
        border = "double",
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local lspkind = require("lspkind")
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = lspkind.symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,

              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
      documentation = { auto_show = true, window = { border = "double" } },
    },
    cmdline = {
      keymap = {
        preset = "default",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      completion = {
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ":"
          end,
        },
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "npm", "dictionary", "ripgrep" },
      providers = { ripgrep = ripgrep, npm = npm, dictionary = dictionary },
    },

    fuzzy = { implementation = "prefer_rust" },
  },
  opts_extend = { "sources.default" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      config = function()
        -- Snippets
        require("snippets.javascript.init")
        require("snippets.css.init")
        require("snippets.astro.init")
        require("snippets.vue.init")

        vim.keymap.set({ "n", "i" }, "<C-Esc>", function()
          require("luasnip").unlink_current()
        end, { desc = "Unlink current snippet" })
      end,
    },
    "onsails/lspkind.nvim",
    "nvim-tree/nvim-web-devicons",
    "mikavilpas/blink-ripgrep.nvim",
    "alexandre-abrioux/blink-cmp-npm.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
  },
}
return M
