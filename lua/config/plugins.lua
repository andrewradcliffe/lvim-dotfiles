return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            require("copilot_cmp").setup({
                suggestion = { enabled = false },
                panel = { enabled = false }
            })
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("C:\\Repos\\TVA-API\\.venv\\Scripts\\python.exe")
            table.insert(require("dap").configurations.python, {
                type = "python",
                request = "launch",
                name = "Launch Flask Server",
                program =  "C:\\repos\\TVA-API\\server.py",
                pythonPath = "C:\\Repos\\TVA-API\\.venv\\Scripts\\python.exe",
            })
        end
    },
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        opts = {
            transparent_background = true,
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "none" },
                neotest = true,
                neotree = true,
                noice = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
            custom_highlights = function(colors)
                return {
                    LineNrAbove = { fg='#6c7086', bold=true },
                    LineNr = { fg='#cdd6f4', bold = true },
                    LineNrBelow = { fg='#6c7086', bold=true },
                }
            end,
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        }
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "Work",
                    path = "C:\\Work Notes"
                }
            },
            templates = {
                subdir = "templates"
            },
            daily_notes = {
                folder = "Daily Notes",
                date_format = "%Y-%m-%d",
                template = "Daily Note Template.md"
            },
            completion = {
                nvim_cmp = true
            },
            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = true, expr = true, buffer = true },
                },
                -- ["<cr>"] = {
                --     action = function()
                --         return require("obsidian").util.smart_action()
                --     end,
                --     opts = { buffer = true, expr = true }
                -- },
            }
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "nvzone/typr",
        enabled = false, -- Plugin doesn't support transparent background
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats"}
    },
    -- Fix python indenting
    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python"
    },
    {
        "echasnovski/mini.ai",
        version = "*",
        config = function()
            require("mini.ai").setup()
        end
    },
}
