-- Disable F1 key
vim.api.nvim_set_keymap('n', '<F1>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<F1>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F1>', '<Nop>', { noremap = true, silent = true })

-- Telescope searching
lvim.builtin.which_key.mappings["sw"] = { "<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<cr>", "Live Grep Word Under Cursor" }
lvim.builtin.which_key.mappings["sF"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "Find File Everywhere" }
lvim.builtin.which_key.mappings["sT"] = {
    function()
        require("telescope.builtin").live_grep {
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
    }
    end,
    "Find Text Everywhere",
}

-- Restart LSP when errors won't go away
lvim.builtin.which_key.mappings["lR"] = { "<cmd>LspRestart<cr>", "Restart LSP" }

-- Toggle inline git blame
lvim.builtin.which_key.mappings["gB"] = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Line Blame (inline)"}

-- Close all buffers but the current one
lvim.builtin.which_key.mappings["bC"] = { "<cmd>BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>", "Close all other buffers" }

-- Toggle floating terminal
lvim.keys.normal_mode["<C-t>"] = "<cmd>ToggleTerm direction=float<cr>"
lvim.keys.term_mode["<C-t>"] = "<cmd>ToggleTerm direction=float<cr>"

-- Obsidian Keybindings
lvim.builtin.which_key.mappings["o"] = {
    name = "+Obsidian",
    t = { "<cmd>ObsidianToday<cr>" , "Open today's daily note" },
    y = { "<cmd>ObsidianYesterday<cr>" , "Open yesterday's daily note" },
    d = {
        function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":ObsidianToday ", true, false, true), "n", false)
        end,
        "Open daily note with input"
    },
    c = {
        function()
            return require("obsidian").util.toggle_checkbox()
        end,
        "Toggle checkbox"
    }
}

-- Markdown Preview
lvim.builtin.which_key.mappings["m"] = {
    name = "+Markdown",
    p = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview" },
    P = { "<cmd>MarkdownPreview<cr>", "Open Markdown Preview" },
    S = { "<cmd>MarkdownPreviewStop<cr>", "Stop Markdown Preview" },
}

lvim.builtin.which_key.mappings["p"] = {
    name = "+Python",
    m = { '"mPGdd6gg$', "Migration Script Boilerplate" }
}
