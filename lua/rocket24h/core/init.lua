-- Autocmds, in case I ever need them
require("rocket24h.core.cmds")

-- Neovim UI and/or QoL config here
require("rocket24h.core.options")

-- Not to forget some default keymaps
require("rocket24h.core.keymaps").default()
-- Comment the line below if you don't want to lazy load nvim-tree
require("rocket24h.core.keymaps").nvim_tree()
require("rocket24h.core.keymaps").dap()
