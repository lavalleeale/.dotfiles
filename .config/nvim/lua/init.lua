require('telescope').load_extension('fzf')
require('Comment').setup()
function goDef ()
	local ft = vim.api.nvim_buf_get_option(0, 'filetype')
	if ft == 'go' then
		go.def.Jump('', 0)
	end
end
vim.keymap.set('n', 'gd', goDef, {})
