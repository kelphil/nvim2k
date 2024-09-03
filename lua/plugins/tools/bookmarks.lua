local status_ok, bookmarks = pcall(require, "browser_bookmarks")
if not status_ok then
	return
end

bookmarks.setup({
    selected_browser = "brave",
    profile_name = "Work",
    config_dir = "/mnt/c/Users/kephilip/AppData/Local/BraveSoftware/Brave-Browser/User Data/",
    full_path = true,
    url_open_command = "wslview $1 >> /dev/null 2>&1",
    url_open_plugin = nil,
    buku_include_tags = false,
    debug = false,
})
