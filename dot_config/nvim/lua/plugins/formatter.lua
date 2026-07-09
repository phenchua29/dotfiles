return {
	{
		"mhartington/formatter.nvim",
		cmd = "Format",
		opts = function()
			return {
				filetype = {
					lua = require("formatter.filetypes.lua").stylua,
					html = require("formatter.filetypes.html").prettier,
					css = require("formatter.filetypes.css").prettier,
					javascript = require("formatter.filetypes.javascript").prettier,
					javascriptreact = require("formatter.filetypes.javascriptreact").prettier,
					typescript = require("formatter.filetypes.typescript").prettier,
					typescriptreact = {
						require("formatter.filetypes.typescriptreact").prettier,
						require("formatter.filetypes.typescriptreact").eslint_d,
					},
					json = require("formatter.filetypes.json").prettier,
					markdown = require("formatter.filetypes.markdown").prettier,
					cs = require("formatter.filetypes.cs").clangformat,
					c = require("formatter.filetypes.c").clangformat,
					cpp = require("formatter.filetypes.cpp").clangformat,
					java = require("formatter.filetypes.java").clangformat,
					sh = require("formatter.filetypes.sh").shfmt,
					terraform = require("formatter.filetypes.terraform").terraformfmt,
					hcl = require("formatter.filetypes.terraform").terraformfmt,
					python = {
						require("formatter.filetypes.python").ruff,
						require("formatter.filetypes.python").iruff,
					},
					rust = require("formatter.filetypes.rust").rustfmt,
					go = require("formatter.filetypes.go").gofmt,
					toml = require("formatter.filetypes.toml").taplo,
					yaml = require("formatter.filetypes.yaml").prettier,
				},
			}
		end,
	},
}
