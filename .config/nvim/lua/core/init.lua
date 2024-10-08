local options = {
  tabstop = 2,                             -- number of columns occupied by tab
  cmdheight = 1,                           -- set vertical space on command line to display messages
  shiftwidth = 2,                          -- width for autoindents
  completeopt = { 'menuone', 'noselect' }, -- show completion menu even when there is only one item, and don't auto select the first item
  pumheight = 10,                          -- popup menu height
  showtabline = 0,                         -- never show tabs
  smartcase = true,                        -- override 'ignorecase' option if a capital letter is present in search
  expandtab = true,                        -- converts tabs to whitespaces
  number = true,                           -- show line numbers
  relativenumber = true,                   -- show relative line numbers
  compatible = false,                      -- disable vi compatibility
  showmatch = true,                        -- show matching bracket, parenthesis, etc. when you insert one
  wrap = false,                            -- disable wrapping
  hlsearch = true,                         -- highlight search results
  ignorecase = true,                       -- ignore case in search
  incsearch = true,                        -- show search results as you type
  scrolloff = 10,                          -- always show some lines after the cursor for context
  showcmd = true,                          -- show commands as they are being typed
  cursorcolumn = true,                     -- highlight column cursor is in
  cursorline = true,                       -- highlight line cursor is on
  autoindent = true,                       -- indent line the same amount as the last one
  smartindent = true,                      -- intelligent indents
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go the the right of the current window
  termguicolors = true,                    -- enables more colors if supported by your terminal
  conceallevel = 0,                        -- text is always shown normally, for example when writing markdown
  undofile = true,                         -- persistant undo if you close and reopen file
  updatetime = 300,                        -- some plugins have refresh times that depend on this, a lower value can make them quicker
  signcolumn = "yes",                      -- always show the sign column, otherwise it will shift the text everytime
  backspace = {'indent', 'eol', 'start'},  -- make backspace work more predictibly
  sidescrolloff = 5,                       -- always show some lines to the side of the cursor
  showmode = false,                        -- lualine shows the mode so we dont need nvim to
  modeline = true,                   -- enable modelines for neovim
  foldmethod = "manual",
  clipboard = "unnamedplus",
}

-- Do not automatically insert comments
vim.api.nvim_create_autocmd("FileType", {
pattern = "*",
group = vim.api.nvim_create_augroup("AutoFormat", { clear = true }),
command = 'lua vim.opt.formatoptions:remove{"r","o"}',
})

-- Use treesitter for code folding
vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]])

-- Neovide options
vim.g.neovide_input_use_logo = true
vim.g.neovide_refresh_rate = 120
vim.g.neovide_cursor_animation_length = 0.03
vim.g.hardtime_default_on = 1
vim.g.hardtime_timeout = 500

-- set vim option for every item in options table
for k, v in pairs(options) do
  vim.opt[k] = v
end
