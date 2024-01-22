local status_ok, bookmarks = pcall(require, "browser_bookmarks")
if not status_ok then
	return
end

bookmarks.setup({
	version = "*",
	-- Below options added directly to the config file in userpath
	-- /home/kephilip/.local/share/nvim/lazy/browser-bookmarks.nvim/lua/browser_bookmarks/config.lua
	-- The opts table below is not getting read/applied
	opts = {
		selected_browser = "brave",
		profile_name = "Work",
		config_dir = "/mnt/c/Users/kephilip/AppData/Local/BraveSoftware/Brave-Browser/User Data/Default",
		url_open_command = "wslview $1 >> /dev/null 2>&1",
	},
})
