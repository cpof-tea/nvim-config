return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Package manager
	use 'wakatime/vim-wakatime'
	use 'gpanders/editorconfig.nvim'
	use 'hrsh7th/nvim-cmp' -- Completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'ggandor/lightspeed.nvim'
	use 'L3MON4D3/LuaSnip'
	use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
	use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
end)

