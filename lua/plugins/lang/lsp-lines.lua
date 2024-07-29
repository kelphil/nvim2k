local status_ok, lsp_lines = pcall(require, 'lsp_lines')
if not status_ok then
    return
end

vim.diagnostic.config({ virtual_text = false })
-- vim.diagnostic.enable()
lsp_lines.setup()
