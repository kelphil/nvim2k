require('core.options')
require('core.functions')
require('core.keymaps')
require('core.autocmd')
require('plugins.lazy')

pcall(require, 'user')
