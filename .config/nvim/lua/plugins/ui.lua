return {
  -- Cursor animation
  "echasnovski/mini.animate",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.scroll = {
      enable = false,
    }
  end,
}
