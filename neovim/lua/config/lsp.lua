local lspconfig = require('lspconfig')

lspconfig.pyright.setup {
	autostart = true,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = 'workspace',
				useLibraryCodeForTypes = true
			}
		}
	},
}
lspconfig.clangd.setup {
	autostart = true,
}


lspconfig.lua_ls.setup {
	autostart = true,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most commonly LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				-- globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<F18>', vim.lsp.buf.rename, opts) -- Shift + F6
		--vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		-- Format current line
		vim.keymap.set('n', '==', function()
			local line = vim.api.nvim_win_get_cursor(0)[1]
			vim.lsp.buf.format({
				range = {
					['start'] = { line, 0 },
					['end'] = { line, 0 },
				}
			})
		end, opts)
		-- Format visual selection
		vim.keymap.set('v', '=', function()
			vim.lsp.buf.format()
			vim.api.nvim_input('<ESC>')
		end, opts)
		vim.keymap.set('n', 'g=', vim.lsp.buf.format, opts)
	end
})
return lspconfig
