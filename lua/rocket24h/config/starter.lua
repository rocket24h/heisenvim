local default_header = function()
	local hour = tonumber(vim.fn.strftime("%H"))
	-- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
	local part_id = math.floor((hour + 4) / 8) + 1
	local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
	local username = vim.loop.os_get_passwd()["username"] or "USERNAME"
	return ("Good %s, %s"):format(day_part, username)
end

require("mini.starter").setup({})
