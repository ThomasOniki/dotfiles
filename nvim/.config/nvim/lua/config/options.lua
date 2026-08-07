local o = vim.o

o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.number = true
o.relativenumber = true
o.timeoutlen = 500

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
  severity_sort = true,
})
