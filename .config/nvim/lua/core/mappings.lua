vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

local function remap(mode, rhs, lhs, bufopts, desc)
    if bufopts == nil then
      bufopts = {}
    end
    bufopts.desc = desc
    vim.api.nvim_set_keymap(mode, rhs, lhs, bufopts)
end


remap("n", "<S-l>", ":bnext<CR>", opts, "Next Buffer")
remap("n", "<S-h>", ":bprevious<CR>", opts, "Previous Buffer")

local wk = require("which-key")

wk.register({
  f = {
    name = "File Tree", -- optional group name
    f = { "<cmd>NvimTreeFocus<cr>", "Focus Tree" }, -- create a binding with label
  },
  a = {},
  s = {},
  d = {},
  g = {},
}, { prefix = "<leader>" })
