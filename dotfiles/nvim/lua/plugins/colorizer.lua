return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*",                     -- highlight all filetypes
      css = { rgb_fn = true }, -- enable parsing rgb() functions in CSS
      html = { names = true }  -- enable named colors like 'red'
    })
  end
}
