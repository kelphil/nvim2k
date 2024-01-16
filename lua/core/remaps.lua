local function remap(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true })
end

-- Escape in terminal mode
remap('t', '<esc>', '<C-\\><C-n>')
