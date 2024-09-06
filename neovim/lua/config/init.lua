-- _G.__is_log = true

require('config.skin')
require('config.buf')
require('config.jump')
require('config.treesitter')
require('config.diag')
require('config.cmp')
require('config.lsp')
require('config.molten')
require('config.misc')
require('config.typefocus')
require('config.languages')


-- vim.keymap.set('n', '2', function ()
-- 	vim.notify(string.format("get_cursor %d  line %d", vim.api.nvim_win_get_cursor(0)[2], #vim.api.nvim_get_current_line()))
-- end)
--
-- vim.keymap.set('i', '2', function ()
-- 	vim.notify(string.format("get_cursor %d  line %d", vim.api.nvim_win_get_cursor(0)[2], #vim.api.nvim_get_current_line()))
-- end)


-- vim.api.nvim_create_autocmd("TextChangedI", {
-- 	callback = function ()
-- 		local line = vim.api.nvim_get_current_line()
-- 		-- vim.notify(string.format("TextChangedI, len: %d, line: %s", #line, line))
-- 	end
-- })

-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	callback = function ()
-- 		local line = vim.api.nvim_get_current_line()
-- 		-- vim.notify(string.format("InsertEnter, len: %d, line: %s", #line, line))
-- 	end
-- })

