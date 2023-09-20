-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

map(
    "n",
    "<leader>xs",
    ":FloatermNew --disposable --name=duaroot --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root> dua i<CR>",
    { desc = "Workspace Size (root dir)" }
)

map(
    "n",
    "<leader>xS",
    ":FloatermNew --disposable --name=duabuffer --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<buffer> dua i<CR>",
    { desc = "Workspace Size (cwd)" }
)

map(
    "n",
    "<leader>fx",
    ":FloatermNew --disposable --name=xplrroot --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root> xplr<CR>",
    { desc = "Xplr (root dir)" }
)

map(
    "n",
    "<leader>fX",
    ":FloatermNew --disposable --name=xplrbuffer --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<buffer> xplr<CR>",
    { desc = "Xplr (cwd)" }
)

map(
    "n",
    "<leader>gg",
    ":FloatermNew --disposable --name=lazygitroot --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root> lazygit<CR>",
    { desc = "Lazygit (root dir)" }
)

map(
    "n",
    "<leader>gG",
    ":FloatermNew --disposable --name=lazygitbuffer --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<buffer> lazygit<CR>",
    { desc = "Lazygit (cwd)" }
)

map(
    "n",
    "<leader>fd",
    ":FloatermNew --disposable --name=lazydocker --opener=edit --titleposition=center --height=0.85 --width=0.85 lazydocker<CR>",
    { desc = "Lazydocker" }
)

map("n", "<leader>T", ":Telescope floaterm<CR>", { desc = "Terminals" })

map("n", "<leader>sz", ":Telescope zoxide list<CR>", { desc = "Zoxide" })

map("n", "<leader>sL", ":Telescope luasnip<CR>", { desc = "Snippets (Luasnip)" })

map("n", "<leader>sp", ":Telescope lazy<CR>", { desc = "Plugins (Lazy)" })

map("n", "<leader>si", ":Telescope import<CR>", { desc = "Imports" })

map(
    "n",
    "<leader>ft",
    ":FloatermNew --name=termroot --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root><CR>",
    { desc = "New Terminal (root dir)" }
)
map(
    "n",
    "<leader>fT",
    ":FloatermNew --name=termcwd --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<buffer><CR>",
    { desc = "New Terminal (cwd)" }
)
map("n", "<A-Left>", "FloatermPrev<CR>", { desc = "Previous Terminal" })
map("n", "<A-Right>", "FloatermNext<CR>", { desc = "Next Terminal" })
map("n", "<c-Return>", ":FloatermToggle<CR>", { desc = "Toggle Terminal" })
map("t", "<C-Return>", "<C-\\><C-n><C-\\><C-n>:FloatermToggle<CR>", { desc = "Toggle Terminal", nowait = true })

vim.keymap.set("n", "<leader>gU", vim.cmd.UndotreeToggle, { noremap = true, silent = true, desc = "Toggle Undotree" })

vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", { noremap = true, silent = true, desc = "Pick Color" })
vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", { noremap = true, silent = true, desc = "Pick Color" })

-- Open compiler
vim.keymap.set("n", "<leader>ccc", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true, desc = "Open Compiler" })

vim.keymap.set("n", "<leader>ccR", function()
    vim.cmd("CompilerStop")
    vim.cmd("CompilerRedo")
end, { noremap = true, silent = true, desc = "Redo Compiler" })

-- Toggle compiler results
vim.keymap.set(
    "n",
    "<leader>ccr",
    "<cmd>CompilerToggleResults<cr>",
    { noremap = true, silent = true, desc = "Toggle Compiler Results" }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>cps",
    "<cmd>lua require('package-info').show({ force = true })<cr>",
    { silent = true, noremap = true, desc = "Show Package Versions" }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>cpu",
    "<cmd>lua require('package-info').update()<cr>",
    { silent = true, noremap = true, desc = "Update Package" }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>cpr",
    "<cmd>lua require('package-info').delete()<cr>",
    { silent = true, noremap = true, desc = "Remove Package" }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>cpv",
    "<cmd>lua require('package-info').change_version()<cr>",
    { silent = true, noremap = true, desc = "Change Package Version" }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>cpn",
    "<cmd>lua require('package-info').install()<cr>",
    { silent = true, noremap = true, desc = "Install New Dependency" }
)

vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("n", "N", "Nzzzv")

local function goto_prev_node()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local node = ts_utils.get_node_at_cursor()
    if not node then
        return
    end
    local dest_node = ts_utils.get_previous_node(node, true, true)
    if not dest_node then
        local cur_node = node:parent()
        while cur_node do
            dest_node = ts_utils.get_previous_node(cur_node, false, false)
            if dest_node then
                break
            end
            cur_node = cur_node:parent()
        end
    end
    if not dest_node then
        return
    end
    ts_utils.goto_node(dest_node)
end

local function goto_next_node()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local node = ts_utils.get_node_at_cursor()
    if not node then
        return
    end
    local dest_node = ts_utils.get_next_node(node, true, true)
    if not dest_node then
        local cur_node = node:parent()
        while cur_node do
            dest_node = ts_utils.get_next_node(cur_node, false, false)
            if dest_node then
                break
            end
            cur_node = cur_node:parent()
        end
    end
    if not dest_node then
        return
    end
    ts_utils.goto_node(dest_node)
end

local function goto_parent_node()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local node = ts_utils.get_node_at_cursor()
    if not node then
        return
    end
    local dest_node = node:parent()
    if not dest_node then
        return
    end
    ts_utils.goto_node(dest_node)
end

local function goto_child_node()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local node = ts_utils.get_node_at_cursor()
    if not node then
        return
    end
    local dest_node = ts_utils.get_named_children(node)[1]
    if not dest_node then
        return
    end
    ts_utils.goto_node(dest_node)
end

local keyopts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v", "o", "i" }, "<A-o>", goto_parent_node, keyopts)
vim.keymap.set({ "n", "v", "o", "i" }, "<A-i>", goto_child_node, keyopts)
vim.keymap.set({ "n", "v", "o", "i" }, "<A-n>", goto_next_node, keyopts)
vim.keymap.set({ "n", "v", "o", "i" }, "<A-p>", goto_prev_node, keyopts)

vim.keymap.set({ "n", "v", "o", "i" }, "<A-h>", goto_parent_node, keyopts)
vim.keymap.set({ "n", "v", "o", "i" }, "<A-l>", goto_child_node, keyopts)
vim.keymap.set({ "n", "v", "o", "i" }, "<A-j>", goto_next_node, keyopts)
vim.keymap.set({ "n", "v", "o", "i" }, "<A-k>", goto_prev_node, keyopts)
