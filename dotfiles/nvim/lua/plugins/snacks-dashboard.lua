return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- make sure dashboard/preset exists
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.keys = opts.dashboard.preset.keys or {}

      -- insert *after* the Lazy button
      -- find index of Lazy shortcut
      local insert_at = 1
      for i, entry in ipairs(opts.dashboard.preset.keys) do
        if entry.key == "l" then
          insert_at = i + 1
          break
        end
      end

      table.insert(opts.dashboard.preset.keys, insert_at, {
        icon = "󰺵 ",
        key = "L",
        desc = "LeetCode",
        action = ":Leet",
      })
    end,
  },
}
