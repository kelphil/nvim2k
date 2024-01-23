local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
	return
end

obsidian.setup({
	workspaces = {
		{
			name = "Notes",
			-- path = "/home/kephilip/repos/notes",
			path = "/mnt/c/Users/kephilip/OneDrive - Advanced Micro Devices Inc/DOCS/notes",
		},
	},
	completion = {
		-- Set to false to disable completion.
		nvim_cmp = true,

		-- Trigger completion at 2 chars.
		min_chars = 2,

		-- Where to put new notes created from completion. Valid options are
		--  * "current_dir" - put new notes in same directory as the current buffer.
		--  * "notes_subdir" - put new notes in the default notes subdirectory.
		new_notes_location = "current_dir",

		-- Control how wiki links are completed with these (mutually exclusive) options:
		--
		-- 1. Whether to add the note ID during completion.
		-- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
		-- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
		prepend_note_id = true,
		-- 2. Whether to add the note path during completion.
		-- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
		-- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
		prepend_note_path = false,
		-- 3. Whether to only use paths during completion.
		-- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
		-- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
		use_path_only = false,
	},
	-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
	-- way then set 'mappings = {}'.
	mappings = {
		-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		-- Toggle check-boxes.
		-- ["<leader>ch"] = {
		-- 	action = function()
		-- 		return require("obsidian").util.toggle_checkbox()
		-- 	end,
		-- 	opts = { buffer = true },
		-- },
	},
	-- Optional, customize how names/IDs for new notes are created.
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d-%a",
		time_format = "%H:%M",
	},
	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "dailies",
		-- Optional, if you want to change the date format for the ID of daily notes.
		date_format = "%Y-%m-%d",
		-- Optional, if you want to change the date format of the default alias of daily notes.
		alias_format = "%B %-d, %Y",
		-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
		template = nil,
	},
	-- Optional, by default commands like `:ObsidianSearch` will attempt to use
	-- telescope.nvim, fzf-lua, fzf.vim, or mini.pick (in that order), and use the
	-- first one they find. You can set this option to tell obsidian.nvim to always use this
	-- finder.
	finder = "telescope.nvim",

	-- Optional, configure key mappings for the finder. These are the defaults.
	-- If you don't want to set any mappings this way then set
	finder_mappings = {
		-- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
		-- Currently only telescope supports this.
		new = "<C-s>",
	},

	-- Optional, sort search results by "path", "modified", "accessed", or "created".
	-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
	-- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
	sort_by = "modified",
	sort_reversed = true,

	-- Optional, determines how certain commands open notes. The valid options are:
	-- 1. "current" (the default) - to always open in the current window
	-- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
	-- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
	open_notes_in = "current",

	-- Optional, configure additional syntax highlighting / extmarks.
	-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
	ui = {
		enable = true, -- set to false to disable all additional syntax features
		update_debounce = 200, -- update delay after a text change (in milliseconds)
		-- Define how various check-boxes are displayed
		checkboxes = {
			-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
			["x"] = { char = "", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			-- Replace the above with this if you don't have a patched font:
			-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
			-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

			-- You can also add more custom ones...
		},
		-- Use bullet marks for non-checkbox lists.
		bullets = { char = "•", hl_group = "ObsidianBullet" },
		external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		-- Replace the above with this if you don't have a patched font:
		-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		reference_text = { hl_group = "ObsidianRefText" },
		highlight_text = { hl_group = "ObsidianHighlightText" },
		tags = { hl_group = "ObsidianTag" },
		hl_groups = {
			-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
			ObsidianTodo = { bold = true, fg = "#f78c6c" },
			ObsidianDone = { bold = true, fg = "#89ddff" },
			ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
			ObsidianTilde = { bold = true, fg = "#ff5370" },
			ObsidianBullet = { bold = true, fg = "#89ddff" },
			ObsidianRefText = { underline = true, fg = "#c792ea" },
			ObsidianExtLinkIcon = { fg = "#c792ea" },
			ObsidianTag = { italic = true, fg = "#89ddff" },
			ObsidianHighlightText = { bg = "#75662e" },
		},
	},
	-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
	-- URL it will be ignored but you can customize this behavior here.
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		-- vim.fn.jobstart({ "open", url }) -- Mac OS
		vim.fn.jobstart({ "xdg-open", url }) -- linux
	end,
})

-- Minimum Conceal Level
vim.opt.conceallevel = 1
