local telescope = require('telescope')
telescope.load_extension('fzf')
telescope.setup {
	pickers = {
		find_files = {
			hidden = true
		}
	}
}
require('Comment').setup()
require("nvim-tree").setup()
require("auto-session").setup {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
}

local pywal = require('pywal')
pywal.setup()

function goDef ()
	local ft = vim.api.nvim_buf_get_option(0, 'filetype')
	if ft == 'go' then
		go.def.Jump('', 0)
	end
end
vim.keymap.set('n', 'gd', goDef, {})
