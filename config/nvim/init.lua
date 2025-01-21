local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end


vim.opt.rtp:prepend(lazypath)


vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.ignorecase = true
-- vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"






local function add_ruby_deps_command(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
            local params = vim.lsp.util.make_text_document_params()
            local showAll = opts.args == "all"

            client.request("rubyLsp/workspace/dependencies", params, function(error, result)
                if error then
                    print("Error showing deps: " .. error)
                    return
                end

                local qf_list = {}
                for _, item in ipairs(result) do
                    if showAll or item.dependency then
                        table.insert(qf_list, {
                            text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
                            filename = item.path
                        })
                    end
                end

                vim.fn.setqflist(qf_list)
                vim.cmd('copen')
            end, bufnr)
        end,
        { nargs = "?", complete = function() return { "all" } end })
end





plugins = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            color_overrides = {
                mocha = {
                    -- base = "#1d2021"
                    -- base = "#0c0d0e"
                    -- base = "#151719"
                    -- base = "#131416"
                    base = "#101012"
                }
            }
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line missing-fields
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "lua", "javascript", "typescript", "markdown", "markdown_inline" },
                auto_install = false,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end
                },
                ignore_install = {},
                sync_install = false,
            }
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(opts)
            -- Telescope keys
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
            -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Telescope buffers' })
            --vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

            vim.keymap.set("n", "<leader>en", function()
                require("telescope.builtin").find_files {
                    cwd = vim.fn.stdpath("config")
                }
            end)
        end
    },

    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        lazy = false,
        version = 'v0.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' }
            },
            signature = { enabled = true }
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    }
                }
            }
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").lua_ls.setup { capabilities = capabilities }
            require("lspconfig").vtsls.setup { capabilities = capabilities }
            require("lspconfig").svelte.setup { capabilities = capabilities }
            require("lspconfig").ruby_lsp.setup {
                capabilities = capabilities,
                on_attach = function(client, buffer)
                    add_ruby_deps_command(client, buffer)
                end,
            }
            require("lspconfig").intelephense.setup({
                capabilities = capabilities,
                filetypes = { "php" }
            })
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "vtsls" },
                automatic_installation = false
            }
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
            local api = require("Comment.api")
            local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
            vim.keymap.set("n", "<C-_>", api.toggle.linewise.current)
            vim.keymap.set("x", "<C-_>", function() 
                vim.api.nvim_feedkeys(esc, "nx", false)
                api.toggle.linewise(vim.fn.visualmode())
            end)
        end
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
            -- "ibhagwan/fzf-lua"
        },
        config = true
    }
}


require("lazy").setup(plugins, opts)




vim.cmd.colorscheme "catppuccin-mocha"

-- Customize line number colors
vim.api.nvim_set_hl(0, "LineNr", { fg = "#bd9700" })                    -- Absolute line numbers
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#a84300", bold = true }) -- Current line number


vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ hlgroup = "IncSearch", timeout = 100 })
    end
})



local function format_selection()
    local start_pos = vim.api.nvim_buf_get_mark(0, '<') -- get start position of selection
    local end_pos = vim.api.nvim_buf_get_mark(0, '>')   -- get start position of selection

    local range = {
        start = { start_pos[1] - 1, start_pos[2] }, -- convert to 0-based indexing
        ['end'] = { end_pos[1] - 1, end_pos[2] }
    }

    vim.lsp.buf.format { range = range }
end


-- keymaps
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")

-- do not overwrite clipboard on paste over selection
vim.keymap.set('x', 'p', 'P')
vim.keymap.set('n', '<C-v>', 'p')
vim.keymap.set('i', '<C-v>', '<Esc>pA')

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format() end)
vim.keymap.set("v", "<space>f", format_selection)

vim.keymap.set("n", "<space>n", vim.diagnostic.goto_next)
