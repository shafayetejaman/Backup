return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lang = "cpp", -- change this
  },
}
