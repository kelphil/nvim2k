local status_ok, catppuccin = pcall(require, 'catppuccin')
if not status_ok then
    return
end

catppuccin.setup({
    name = "catppuccin",
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end
})
