vim.opt.relativenumber = true
vim.opt.listchars = { tab = '→ ', space = '•', eol = '↵' }

vim.cmd([[
	highlight Comment cterm=none ctermfg=2
	highlight Type cterm=none ctermfg=6
	highlight Statement cterm=bold ctermfg=5
	highlight Identifier cterm=none ctermfg=none
	highlight Function cterm=none ctermfg=3
	highlight Boolean cterm=none ctermfg=4
	highlight Number cterm=none ctermfg=4
	highlight String cterm=none ctermfg=1
	highlight NormalFloat ctermfg=NONE ctermbg=NONE
	highlight FloatBorder ctermfg=NONE ctermbg=NONE
]])

require('plugins')

syntaxStack = require('syntaxStack')
vim.keymap.set('n', 'gm', ':lua syntaxStack()<CR>')

local cmp = require('cmp')

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		-- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-y>'] = cmp.config.disable,
		['<C-e>'] = cmp.mapping.abort(),
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'cmp_tabnine' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	}),
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
	show_prediction_strength = false;
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local utils = require('utils')
local opts = { noremap=true, }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local newOpts = utils.merge(opts, { buffer = bufnr })

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, newOpts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, newOpts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, newOpts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, newOpts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, newOpts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, newOpts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, newOpts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, newOpts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, newOpts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, newOpts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, newOpts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, newOpts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, newOpts)
end

--local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
--function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
local orig_nvim_open_win = vim.api.nvim_open_win
function vim.api.nvim_open_win(buffer, enter, config)
	config.border = 'single'
	return orig_nvim_open_win(buffer, enter, config)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		}
	}
end

