-- require('leap').create_default_mappings()
local leap = require('leap')
vim.keymap.set('n', 'f', '<Plug>(leap-forward)')
vim.keymap.set('n', 'F', '<Plug>(leap-backward)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
leap.opts.safe_labels = 'fnug/FHLUNS?'
-- leap.opts.labels = 'fnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?'
leap.opts.labels = ''

require('telescope').setup{
	defaults = {
		mappings = {
			n = {
				["q"] = require('telescope.actions').close,
			},
			i = {
				["<esc>"] = require('telescope.actions').close,
			}
		}
	}
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
