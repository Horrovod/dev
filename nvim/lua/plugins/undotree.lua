return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
	},
	init = function()
		-- Настройки (опционально)
		vim.g.undotree_WindowLayout = 2   -- 2: левая панель для дерева, правая для diff
		vim.g.undotree_DiffAutoOpen = 1   -- Автоматически открывать diff
		vim.g.undotree_SetFocusWhenToggle = 1 -- Фокус на дерево при открытии
	end,
}
