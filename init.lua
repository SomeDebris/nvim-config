-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- [[ Setting options ]] See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Print the line number in front of each line
vim.o.number = true

-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
-- option above, see `:h number_relativenumber`
-- vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
-- vim.api.nvim_create_autocmd('UIEnter', {
--   callback = function()
--     vim.o.clipboard = 'unnamedplus'
--   end,
-- })

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- When reaching the end of an on-screen line whose width is larger than that
-- of the terminal window, scroll this many characters to the right.
vim.o.sidescroll = 10

-- Show <tab> and trailing spaces
vim.o.list = true
-- Indicate that a line has preceding characters with "<"
-- Indicate that a line has following characters with ">"
vim.opt.listchars:append({precedes = "<", extends = ">"})

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
-- vim.o.confirm = true

-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Create user commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })

-- create a command `:Gcom` that commits the current file with the supplied commit message
vim.api.nvim_create_user_command('Gcom', function(opts)
  vim.cmd('write')
  vim.cmd('Git add %')
  vim.cmd('Git commit -m ' .. opts.fargs[1])
end, { desc = 'Shorthand for `:Git add % | Git commit -m`', nargs = 1 })

-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
vim.cmd('packadd! nohlsearch')

-- my stuff:
vim.o.wrap = false
vim.o.background = "dark"
vim.o.path = "**"
vim.o.signcolumn = "number"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth= 4
vim.o.expandtab = true

-- person on the internet gave me this:
vim.keymap.set("n", "<leader><space>", vim.diagnostic.open_float)

-- Want to accept code suggestions:
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- vim.cmd([[colorscheme vim]])

-- PLUG:
-- local vim = vim
-- local Plug = vim.fn['plug#']
-- vim.call('plug#begin')
--
-- Plug( 'tpope/vim-fugitive' )
-- Plug( 'tpope/vim-speeddating' )
-- Plug( 'mason-org/mason.nvim')
-- Plug( 'neovim/nvim-lspconfig' )
-- Plug( 'nvim-neo-tree/neo-tree.nvim')
-- Plug( "nvim-lua/plenary.nvim" )
-- Plug("nvim-tree/nvim-web-devicons" )
-- Plug("MunifTanjim/nui.nvim")
--
-- vim.call('plug#end')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-speeddating' },
    { 'mason-org/mason.nvim' },
    { 'rebelot/kanagawa.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'tpope/vim-jdaddy' },
    -- { 'glacambre/firenvim', build = ":call firenvim#install(0)" },
    {
      'nvim-orgmode/orgmode',
      event = 'VeryLazy',
      config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })
      end,
    },
    {
      'JuliaEditorSupport/julia-vim'
    },
    {
      "lervag/vimtex",
      lazy = false,     -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        -- vim.cmd[[set conceallevel=2]]
        vim.g.vimtex_view_method = "sioyek"
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
          options = {
            [[-verbose]],
            [[-shell-escape]],
            [[-file-line-error]],
            [[-synctex=1]],
            [[-interaction=nonstopmode]],
          }
        }
      end
    },
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      branch = 'main',
      build = ':TSUpdate'
    },
    {
      "kiyoon/jupynium.nvim",
      -- build = "pip3 install --user .",
      build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
      -- build = "conda run --no-capture-output -n jupynium pip install .",
      -- python_host = { "uv", "run", "--python=$HOME/.virtualenvs/jupynium/bin/python python", "python" },
      -- jupyter_command = { "uv", "run", "jupyter" },
    },
    -- "rcarriga/nvim-notify",   -- optional
    -- "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
    { "ludovicchabant/vim-gutentags" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {
    colorscheme = { "vim" }
  },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false
  },
})

-- select a colorscheme
if vim.g.started_by_firenvim == true then
    vim.o.background = 'light'
    vim.o.number = false
    vim.o.laststatus = 0
    vim.cmd [[colorscheme vim]]
else
    vim.o.laststatus = 2
    vim.cmd [[colorscheme kanagawa]]
end

require("mason").setup()

local julia_ls_script = vim.fs.joinpath(vim.fn.stdpath('config'), "helpers", "julia_languageserver.jl")

local lsps = {
    { "rust_analyzer" },
    { "fortls" },
    { "pyright" },
    { "ltex_plus" },
    { "awk-language-server" },
    { "texlab" },
    { "gopls" },
    {
        "julials",
        {
            cmd = {"julia", "--startup-file=no", "--history-file=no", julia_ls_script},
            single_file_support = true,
            on_attach = function(client, bufnr)
                -- Disable automatic formatexpr since the LS.jl formatter isn't so nice.
                vim.bo[bufnr].formatexpr = ''
            end,
        capabilities = capabilities,
        }
    },
    -- {
    --     "jetls",
    --     {
    --         cmd = {
    --             "jetls",
    --             "serve",
    --         },
    --         filetypes = { "julia" },
    --         root_markers = { "Project.toml" }
    --     }
    -- },
    { "matlab_ls",
	{
	    settings = {
                MATLAB = {
	            installPath='/home/magnus/.local/MATLAB/R2025b',
                },
            },
        },
    },
    {
        "awk-language-server",
        {
            cmd = { 'awk-language-server' },
            filetypes = { 'awk' },
            single_file_support = true,
            handlers = {
                ['workspace/workspaceFolders'] = function()
                    return {{
                        uri = 'file://' .. vim.fn.getcwd(),
                        name = 'current_dir',
                    }}
                end
            }
        }
    },
    {
        "clangd",
        {
            init_options = {
                -- im using this standard since i want the compiler to
                -- know about true, false, etc - see
                -- https://xnacly.me/posts/2025/clangd-lsp/
                fallbackFlags = { '--std=c23' }
            },
        }
    },
}
for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end

require("jupynium").setup({
    python_host = { "uv", "run", "--python=" .. vim.env.HOME .. "/.virtualenvs/jupynium/bin/python", "python" },
    jupyter_command = { "uv", "run", "jupyter" },
})
