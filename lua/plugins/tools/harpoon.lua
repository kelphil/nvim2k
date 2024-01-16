local status_ok, harpoon = pcall(require, 'harpoon-core')
if not status_ok then
    return
end

harpoon.setup({
    default_action = 'vs',
})

local function map(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { desc = 'Harpoon: ' .. desc })
end

local ui = require('harpoon-core.ui')
for i = 1, 5 do
    local open_file = function()
        ui.nav_file(i)
    end
    map('<leader>' .. i, open_file, 'Open file ' .. i)
end
