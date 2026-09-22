-- Completion (blink.cmp) Configuration

return {
  {
    "saghen/blink.cmp",
    version = "*", -- Pre-built binary download (recommended)
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      return require("plugins.config.cmp")
    end,
    opts_extend = { "sources.default" },
  },
}
