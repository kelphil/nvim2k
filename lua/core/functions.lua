-- Reload neovim config
vim.api.nvim_create_user_command("ReloadConfig", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^plugins") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end, {})

-- Copy relative path
vim.api.nvim_create_user_command("CRpath", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Copy absolute path
vim.api.nvim_create_user_command("CApath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Find and list files with unchecked markdown checkboxes in $NOTES_DIR
vim.api.nvim_create_user_command("Todos", function()
	local notes_dir = vim.env.NOTES_DIR
	local files = vim.fn.systemlist('rg -le "\\[ \\]" --sort created ' .. notes_dir)
	local result = {}
	for _, file in ipairs(files) do
		if vim.fn.filereadable(file) == 1 then
			table.insert(result, file)
		end
	end

	if #result > 0 then
		vim.ui.select(result, { prompt = "Pending TODOs:" }, function(item, _)
			if not item then
				return
			end
			if item then
				vim.cmd("edit " .. item)
			end
		end)
	end
end, {})

-- Options through Telescope
vim.api.nvim_set_keymap(
	"n",
	"<Leader><tab>",
	"<Cmd>lua require('telescope.builtin').commands()<CR>",
	{ noremap = false }
)

-- Find and Replace
vim.api.nvim_create_user_command("FindAndReplace", function(opts)
	vim.api.nvim_command(string.format("cdo %%s/%s/%s", opts.fargs[1], opts.fargs[2]))
	vim.api.nvim_command("cfdo update")
end, { nargs = "*" })

vim.api.nvim_set_keymap("n", "<leader>ir", ":FindAndReplace ", { noremap = true })

-- Create user command for loading Obsidian
vim.api.nvim_create_user_command("Obsidian", function()
	require("obsidian")
	vim.api.nvim_command("ObsidianQuickSwitch")
end, {})

-- MarkdownTODO :: ADD
vim.api.nvim_create_user_command("MarkdownTODOADD", function()
   vim.api.nvim_command('s/^/- [ ] TODO: /')
   vim.api.nvim_command("s/$/ (@" .. os.date("%Y-%m-%d", os.time()+1*24*60*60) .. ")")
   vim.api.nvim_command('let @/ = ""')
end, {})

-- MarkdownTODO :: DONE
vim.api.nvim_create_user_command("MarkdownTODODONE", function()
   vim.api.nvim_command("s/- \\[ \\] TODO: /- [x] TODO: /")
   vim.api.nvim_command('let @/ = ""')
end, {})
