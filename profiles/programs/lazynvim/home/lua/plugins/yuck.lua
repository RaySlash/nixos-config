return {
  "elkowar/yuck.vim",
  vim.filetype.add({
    pattern = { [".*/*/.*%.yuck"] = "yuck" },
  }),
}
