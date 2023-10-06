local o = vim.opt

-- global options
o.autowriteall = true
o.clipboard = "unnamedplus"
o.cmdheight = 0
o.completeopt = { "menu", "menuone", "noselect" }
o.diffopt:append({
  "vertical",
  "hiddenoff",
  "indent-heuristic",
  "linematch:80",
  "algorithm:minimal",
})
o.fillchars = { eob = "󰚌", fold = " ", foldsep = " ", foldclose = "", foldopen = "" }
o.foldlevelstart = 1
o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden"
o.ignorecase = true
o.inccommand = "split"
o.laststatus = 3
o.listchars = {
  eol = "↲",
  tab = "» ",
  lead = "␣",
  trail = "·",
  nbsp = "␣",
  extends = "→",
  precedes = "←",
}
o.mouse = "n"
o.mousemodel = "popup"
o.mousescroll = { "ver:2", "hor:5" }
o.pumblend = 5
o.pumheight = 11
o.scrolloff = 19
o.sessionoptions = { "buffers", "curdir", "tabpages", "winpos", "winsize" }
o.shada = { "!", "'1000", "<50", "s50", "h" }
o.shiftround = true
o.shortmess = "aoOTWIcCF"
o.showbreak = "↪ "
o.sidescrolloff = 5
o.smartcase = true
o.splitbelow = true
o.splitkeep = "screen"
o.splitright = true
o.switchbuf = "usetab"
o.termguicolors = true
o.timeoutlen = 443
o.ttimeoutlen = 19
o.updatetime = 991
o.virtualedit = "block"
o.wildmode = "longest:full,full"
o.winminwidth = 7

-- buffer options
o.expandtab = true
o.foldcolumn = "1"
o.formatoptions = "crqnljp"
o.infercase = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.spelllang = { "en_us" }
o.spelloptions = "camel"
o.tabstop = 2
o.textwidth = 80
o.undofile = true

-- window options
o.breakindent = true
o.breakindentopt:append({ "min:20", "shift:2" })
o.cursorline = true
o.foldnestmax = 5
o.linebreak = true
o.list = true
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.smoothscroll = true
o.wrap = true

-- custom foldtext
_G.custom_foldtext = function()
  local line_cnt = vim.v.foldend - vim.v.foldstart + 1
  local start_part = string.rep("", vim.v.foldlevel)
    .. " "
    .. vim.trim(vim.fn.getline(vim.v.foldstart))
    .. " "
  local end_part = " " .. tostring(line_cnt) .. " "
  local width = vim.go.columns - vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff
  start_part = start_part:sub(1, width - #end_part)
  local mid_part = string.rep("⋅", width - #end_part - #start_part)
  return start_part .. mid_part .. end_part
end

o.foldtext = "v:lua.custom_foldtext()"
-- if vim.treesitter.foldtext then
--   o.foldtext = "v:lua.vim.treesitter.foldtext()"
-- else
--   o.foldtext = "v:lua.custom_foldtext()"
-- end
