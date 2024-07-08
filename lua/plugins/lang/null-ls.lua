local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local hover = null_ls.builtins.hover
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local cspell = require('cspell')

-- Buily in sources: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md

null_ls.setup({
	debug = false,
	border = "rounded",
	log_level = "info",
	diagnostics_format = "#{c} #{m} (#{s})",
	sources = {
        require("none-ls.diagnostics.cpplint"),
        require("none-ls.formatting.jq"),
        -- require("none-ls.code_actions.eslint"),
        -- require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
		code_actions.refactoring,
		completion.spell,
		completion.tags,
		formatting.black,
		formatting.prettier,
		formatting.shfmt,
		formatting.stylua,
		hover.dictionary,
		hover.printenv,
        -- cspell.diagnostics,
        cspell.code_actions,
	},
})
