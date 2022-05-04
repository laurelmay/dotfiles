vim.opt.mouse = 'a'
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.backupdir:remove '.'
vim.opt.spelllang = 'en'

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = 'number'
vim.opt.scrolloff = 5
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.inccommand = 'split'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.cmdheight = 2
vim.opt.shortmess:append 'c'
vim.opt.colorcolumn = '100'
vim.cmd [[
  colorscheme solarized
]]
vim.cmd [[
  highlight ColorColumn ctermbg=DarkCyan guibg=DarkCyan
]]


-- Tabs and stuff
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Performance Settings
vim.opt.hidden = true
vim.opt.lazyredraw = true
vim.opt.updatetime = 300

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
