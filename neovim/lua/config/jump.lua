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
vim.keymap.set('n', ';f', function() vim.cmd("Files") end, {})
vim.keymap.set('n', ';F', builtin.find_files, {})
vim.keymap.set('n', ';g', builtin.live_grep, {})
vim.keymap.set('n', ';G', function() vim.cmd("Rg") end, {})
vim.keymap.set('n', ';b', function() vim.cmd("Buffers") end, {})
vim.keymap.set('n', ';B', builtin.buffers, {})
vim.keymap.set('n', ';l', function() vim.cmd("Lines") end, {})
vim.keymap.set('n', ';t', builtin.builtin, {})

-- " fzf in CURRENT buffer
-- nnoremap <silent>;l :Lines<CR>
-- " fzf in files in this folder (use ctrlp instead)
-- nnoremap <silent>;f :Files<CR>
-- " fzf open buffer
-- nnoremap <silent>;b :Buffers<CR>
-- " fzf open ripgrep finder
-- nnoremap <silent>;g :Rg<CR>
