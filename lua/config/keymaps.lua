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
