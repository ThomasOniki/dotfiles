---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
	},
	cmd = { "DapInstall", "DapUninstall" },
	keys = {
		{
			"<leader>dr",
			function()
				require("dap").continue()
			end,
			desc = "Run/Continue",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},

		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},

		{
			"<leader>de",
			function()
				require("dap").step_over()
			end,
			desc = "Step out",
		},

		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},

		{
			"<leader>dc",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to cursor",
		},
	},
})

table.insert(spec, {
	"rcarriga/nvim-dap-ui",
	dependencies = { "nvim-neotest/nvim-nio" },
	opts = {},
	config = function(_, opts)
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup(opts)

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
	lazy = true,
})

table.insert(spec, {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = "mason-org/mason.nvim",
	opts = {
		automatic_installation = true,
		handlers = {},
		ensure_installed = {
			"codelldb",
		},
	},
	lazy = true,
})

return spec
