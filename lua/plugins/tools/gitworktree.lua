local status_ok, gitworktree = pcall(require, 'git-worktree')
if not status_ok then
    return
end

gitworktree.setup({})
