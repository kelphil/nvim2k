local function load_config(package)
	return function()
		require("plugins." .. package)
	end
end

return {
	-- UI
	{
		"navarasu/onedark.nvim",
		config = load_config("ui.onedark"),
		lazy = false,
		priority = 1000,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	config = load_config("ui.catppuccin"),
	-- 	lazy = false,
	-- },
    { 'echasnovski/mini.icons', version = false },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		config = load_config("ui.lualine"),
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = load_config("ui.indentline"),
		-- main = "ibl",
		-- event = { 'BufReadPre', 'BufNewFile' },
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = load_config("ui.rainbow"),
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"rcarriga/nvim-notify",
		config = load_config("ui.notify"),
		event = "VeryLazy",
		cmd = "Notifications",
	},
	{
		"folke/noice.nvim",
        config = load_config("ui.noice"),
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"stevearc/dressing.nvim",
		config = load_config("ui.dressing"),
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"uga-rosa/ccc.nvim",
		cmd = { "CccHighlighterToggle", "CccConvert", "CccPick" },
	},
	{
		"nvimdev/dashboard-nvim",
		config = load_config("ui.dashboard"),
		-- Only load when no arguments
		event = function()
			if vim.fn.argc() == 0 then
				return "VimEnter"
			end
		end,
		cmd = "Dashboard",
	},
	{
		"gelguy/wilder.nvim",
		build = function()
			vim.cmd([[silent UpdateRemotePlugins]])
		end,
		config = load_config("ui.wilder"),
		keys = { "?" },
	},
	{
		"folke/zen-mode.nvim",
		dependencies = {
			"folke/twilight.nvim",
			config = load_config("ui.twilight"),
		},
		config = load_config("ui.zen-mode"),
		cmd = { "ZenMode", "Twilight" },
	},
	-- {
	--        "ellisonleao/glow.nvim",
	--        config = true,
	--        cmd = "Glow",
	--    },

	-- Language
	-- {
	-- 	"weizheheng/ror.nvim",
	-- 	branch = "main",
	-- 	ft = "ruby",
	-- },
	-- { "tpope/vim-rails", ft = "ruby" },
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		config = load_config("lang.dap"),
		cmd = { "DapUIToggle", "DapToggleRepl", "DapToggleBreakpoint" },
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"olimorris/neotest-rspec",
			"haydenmeade/neotest-jest",
		},
		config = load_config("lang.neotest"),
		cmd = "Neotest",
	},
	-- {
	-- 	"michaelb/sniprun",
	-- 	build = "bash ./install.sh",
	-- 	config = load_config("lang.sniprun"),
	-- 	cmd = "SnipRun",
	-- },
	{
		"ThePrimeagen/refactoring.nvim",
		config = load_config("lang.refactoring"),
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = load_config("lang.trouble"),
        event = { "BufReadPre" },
	},

	-- Tresitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- build = ":TSUpdate",
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- "nvim-treesitter/nvim-treesitter-refactor",
			-- "nvim-treesitter/nvim-treesitter-context",
			-- "RRethy/nvim-treesitter-endwise",
			-- "RRethy/nvim-treesitter-textsubjects",
			-- "windwp/nvim-ts-autotag",
		},
		config = load_config("lang.treesitter"),
		event = { "BufReadPre", "BufNewFile" },
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"VonHeikemen/lsp-zero.nvim",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = load_config("lang.lsp"),
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"folke/neodev.nvim",
		},
		config = load_config("lang.lsp-zero"),
	},
	{
		"folke/neodev.nvim",
		ft = { "lua", "vim" },
		config = load_config("lang.neodev"),
	},
	{
		"nvimdev/lspsaga.nvim",
		config = load_config("lang.lspsaga"),
		event = "LspAttach",
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"mypy",
				-- "ruff",
				"pyright",
			},
		},
		config = load_config("lang.mason"),
		cmd = "Mason",
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"davidmh/cspell.nvim",
			"nvimtools/none-ls-extras.nvim",
			"neovim/nvim-lspconfig",
		},
		config = load_config("lang.null-ls"),
		event = "LspAttach",
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = load_config("lang.cmp"),
		event = "InsertEnter",
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "make install_jsregexp",
		event = "InsertEnter",
	},
	{
		"onsails/lspkind.nvim",
	},
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"zbirenbaum/copilot-cmp",
		},
		config = load_config("lang.copilot"),
		event = "InsertEnter",
	},
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        branch = 'canary',
        dependencies = {
            { 'zbirenbaum/copilot.lua' },
            { 'nvim-lua/plenary.nvim' },
        },
        cmd = {
            'CopilotChat',
            'CopilotChatToggle',
            'CopilotChatDocs',
            'CopilotChatExplain',
            'CopilotChatFix',
            'CopilotChatFixDiagnostic',
            'CopilotChatCommit',
            'CopilotChatCommitStaged',
            'CopilotChatLoad',
            'CopilotChatOptimize',
            'CopilotChatReview',
            'CopilotChatSave',
            'CopilotChatTests',
        },
        config = load_config('lang.copilot-chat'),
    },

	-- Tools
	{
		"ThePrimeagen/git-worktree.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"dhruvmanila/browser-bookmarks.nvim",
		version = "*",
		build = "git checkout kp",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
        config = load_config('tools.bookmarks'),
	},
	{
		"MeanderingProgrammer/harpoon-core.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = load_config("tools.harpoon"),
		event = { "BufReadPre" },
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = load_config("tools.nvim-tree"),
		cmd = "NvimTreeToggle",
	},
	{
		"numToStr/Comment.nvim",
		config = load_config("tools.comment"),
		keys = {
			{
				"gcc",
				mode = { "n" },
				function()
					require("Comment").toggle()
				end,
				desc = "Comment",
			},
			{
				"gc",
				mode = { "v" },
				function()
					require("Comment").toggle()
				end,
				desc = "Comment",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = load_config("tools.todocomments"),
		event = { "BufReadPre" },
	},
	{
		"kylechui/nvim-surround",
		config = load_config("tools.surround"),
		keys = { "cs", "ds", "ys" },
	},
	{
		"windwp/nvim-autopairs",
		config = load_config("tools.autopairs"),
		event = "InsertEnter",
	},
	{
		"windwp/nvim-spectre",
		config = load_config("tools.spectre"),
		cmd = "Spectre",
	},
	{
		"abecodes/tabout.nvim",
		config = load_config("tools.tabout"),
		event = "InsertEnter",
	},
	{
		"folke/flash.nvim",
		config = load_config("tools.flash"),
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"aserowy/tmux.nvim",
		config = load_config("tools.tmux"),
		event = function()
			if vim.fn.exists("$TMUX") == 1 then
				return "VeryLazy"
			end
		end,
	},
	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("hardtime").setup({ enabled = true })
	-- 	end,
	-- 	cmd = "Hardtime",
	-- },
	{
		"chrisgrieser/nvim-spider",
		config = load_config("tools.spider"),
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"folke/which-key.nvim",
		config = load_config("tools.which-key"),
        event = 'VeryLazy'
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
	},
	-- {
	-- 	"renerocksai/telekasten.nvim",
	-- 	dependencies = { "renerocksai/calendar-vim" },
	-- 	config = load_config("tools.telekasten"),
	-- 	cmd = "Telekasten",
	-- },
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = load_config("tools.obsidian"),
		keys = "<leader>n",
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
		opts = {
			default = {
				dir_path = "assets/images", -- directory path to save images to, can be relative (cwd or current file) or absolute
				file_name = "%Y-%m-%d-%H-%M-%S", -- file name format (see lua.org/pil/22.1.html)
				prompt_for_file_name = false, -- ask user for file name before saving, leave empty to use default
			},
		},
	},
	-- {
	-- 	"kndndrj/nvim-dbee",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	build = function()
	-- 		--    "curl", "wget", "bitsadmin", "go"
	-- 		require("dbee").install("curl")
	-- 	end,
	-- 	config = load_config("tools.dbee"),
	-- 	cmd = "DBToggle",
	-- },
	{
		"akinsho/toggleterm.nvim",
		config = load_config("tools.toggleterm"),
		cmd = { "ToggleTerm", "LazygitToggle", "NodeToggle", "PythonToggle", "RubyToggle", "ElixirToggle" },
	},

	-- Telescope
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-symbols.nvim",
			"molecule-man/telescope-menufacture",
			"debugloop/telescope-undo.nvim",
		},
		config = load_config("tools.telescope"),
		cmd = "Telescope",
	},
	{
		"2kabhishek/nerdy.nvim",
		dependencies = { "stevearc/dressing.nvim" },
		cmd = "Nerdy",
	},

	-- Git
	-- {
	-- 	"2kabhishek/co-author.nvim",
	-- 	dependencies = { "stevearc/dressing.nvim" },
	-- 	cmd = "CoAuthor",
	-- },
	{
		"ruifm/gitlinker.nvim",
		config = load_config("tools.gitlinker"),
		keys = "<leader>gy",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = load_config("tools.gitsigns"),
		cmd = "Gitsigns",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = load_config("tools.octo"),
		cmd = "Octo",
	},
}
