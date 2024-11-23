local dap = require("dap")

dap.adapters.dart = {
	type = "executable",
	command = "dart",
	args = { "debug_adapter" },
}

dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch Flutter",
		dartSdkPath = os.getenv("HOME") .. "/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = os.getenv("HOME") .. "/flutter",
		program = "${workspaceFolder}/lib/main.dart",
		cwd = "${workspaceFolder}",
	},
}
