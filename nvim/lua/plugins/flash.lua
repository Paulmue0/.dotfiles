return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- your existing opts here
    },
    keys = {
      -- Disable default 's' mapping
      { "s", mode = { "n", "x", "o" }, false },

      -- Map gs to flash.jump
      {
        "gs",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },

      -- Optional: map gS to treesitter jump or remote if you use those
      {
        "gS",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
