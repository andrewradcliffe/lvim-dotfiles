-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
    set nu rnu
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- Disable F1 key
vim.api.nvim_set_keymap('n', '<F1>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<F1>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F1>', '<Nop>', { noremap = true, silent = true })

-- vim.keymap.set("n", "<leader>fw", function()
--   require("telescope.builtin").live_grep({ default_text = vim.fn.expand("<cword>") })
-- end, { noremap = true, silent = true, desc = "Live Grep Word Under Cursor" })

lvim.builtin.which_key.mappings["fw"] = { "<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<cr>", "Live Grep Word Under Cursor" }
lvim.builtin.which_key.mappings["sF"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "Find File Everywhere" }
lvim.builtin.which_key.mappings["sT"] = {
    function()
        require("telescope.builtin").live_grep {
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
    }
    end,
    "Find Text Everywhere",
}
lvim.keys.normal_mode["gf"] = {
}
lvim.builtin.which_key.mappings["l"]["R"] = { "<cmd>LspRestart<cr>", "Restart LSP" }
lvim.builtin.which_key.mappings["gB"] = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Line Blame (inline)"}
-- lvim.builtin.which_key.mappings["f"]["o"] = { "<cmd>PeekOpen<cr>", "Open Markdown File" }
-- lvim.builtin.which_key.mappings["f"]["c"] = { "<cmd>PeekClose<cr>", "Close Markdown File"}
lvim.keys.normal_mode["<C-t>"] = "<cmd>ToggleTerm direction=float<cr>"
lvim.keys.term_mode["<C-t>"] = "<cmd>ToggleTerm direction=float<cr>"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.o.cursorline = false
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none", ctermbg = "NONE" })

-- set conceallevel only for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.conceallevel = 1
    end,
})

-- clear recent command after 5 seconds
vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        vim.fn.timer_start(5000, function()
            vim.cmd [[ echon ' ']]
        end)
    end
})

lvim.reload_config_on_save = true
lvim.transparent_window = true
-- lvim.transparent_window = false
lvim.colorscheme = "catppuccin"

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

local pyright_opts = {
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace", -- openFilesOnly, workspace
        typeCheckingMode = "off", -- off, basic, strict
        useLibraryCodeForTypes = true
      }
    }
  },
}

require("lvim.lsp.manager").setup("pyright", pyright_opts)

 -- Copilot plugins are defined below:
lvim.plugins = {
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
    -- obsidian.md & markdown
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
                    path = "C:/Work Notes"
                }
            },
            daily_notes = {
                path = "C:/Work Notes/Daily Notes",
                date_format = "%Y-%m-%d",
                template = "C:/Work Notes/Daily Note Template.md"
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
                ["<leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true }
                },
                -- ["<cr>"] = {
                --     action = function()
                --         return require("obsidian").util.smart_action()
                --     end,
                --     opts = { buffer = true, expr = true }
                -- },
            }
        }
    },
    -- {
    --     "nvzone/typr",
    --     dependencies = "nvzone/volt",
    --     opts = {},
    --     cmd = { "Typr", "TyprStats"}
    -- }
}

-- Below config is required to prevent copilot overriding Tab with a suggestion
-- when you're just trying to indent!
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
local on_tab = vim.schedule_wrap(function(fallback)
    local cmp = require("cmp")
    if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    else
        fallback()
    end
end)
lvim.builtin.cmp.mapping["<Tab>"] = on_tab
