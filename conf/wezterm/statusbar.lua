local M = {}
M.setup = function(config, wezterm, color_scheme)
	config.hide_tab_bar_if_only_one_tab = false
	config.show_new_tab_button_in_tab_bar = false
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.tab_max_width = 32

	-- The filled in variant of the > symbol
	local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

	-- This function returns the suggested title for a tab.
	-- It prefers the title that was set via `tab:set_title()`
	-- or `wezterm cli set-tab-title`, but falls back to the
	-- title of the active pane in that tab.
	local function tab_title(tab_info)
		local title = tab_info.tab_title
		-- if the tab title is explicitly set, take that
		if title and #title > 0 then
			return title
		end
		-- Otherwise, use the title from the active pane
		-- in that tab
		return tab_info.active_pane.title
	end

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = tab_title(tab)
		-- ensure that the titles fit in the available space,
		-- and that we have room for the edges.
		title = wezterm.truncate_right(title, max_width - 2)

		-- get last tab index
		local max_id = 0
		for _, t in ipairs(tabs) do
			if t.tab_id > max_id then
				max_id = t.tab_id
			end
		end

		-- Color palette for the backgrounds of each cell
		local colors = color_scheme["ansi"]
		-- Foreground color for the text across the fade
		local text_fg = color_scheme["foreground"]
		if tab.is_active then
			text_fg = color_scheme["background"]
		end

		-- The elements to be formatted
		local elements = {}

		-- Translate a cell into elements
		local function push(text, is_last)
			local cell_no = math.fmod(tab.tab_id, #colors) + 1
			table.insert(elements, { Background = { Color = colors[cell_no + 1] } })
			table.insert(elements, { Foreground = { Color = colors[cell_no] } })
			table.insert(elements, { Text = SOLID_RIGHT_ARROW })
			table.insert(elements, { Foreground = { Color = text_fg } })
			table.insert(elements, { Background = { Color = colors[cell_no + 1] } })
			table.insert(elements, { Text = " " .. text .. " " })
			if is_last then
				table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
				table.insert(elements, { Background = { Color = "#333333" } })
				table.insert(elements, { Text = SOLID_RIGHT_ARROW })
			end
		end

		push(title, tab.tab_id == max_id)

		return elements
	end)

	wezterm.on("update-right-status", function(window, pane)
		-- Each element holds the text for a cell in a "powerline" style << fade
		local cells = {}

		-- Figure out the cwd and host of the current pane.
		-- This will pick up the hostname for the remote host if your
		-- shell is using OSC 7 on the remote host.
		-- TODO: Why is pane id sometimes 0?
		local cwd_uri = nil
		cwd_uri = pane:get_current_working_dir()
		if cwd_uri then
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			local cwd = ""
			local hostname = ""
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				-- Remove the domain name portion of the hostname
				local dot = hostname:find("[.]")
				if dot then
					hostname = hostname:sub(1, dot - 1)
				end
				-- and extract the cwd from the uri
				cwd = cwd_uri:sub(slash)

				table.insert(cells, cwd)
				table.insert(cells, hostname)
			end
		end

		-- I like my date/time in this style: "Wed Mar 3 08:14"
		local date = wezterm.strftime("%a %b %-d %H:%M")
		table.insert(cells, date)

		-- An entry for each battery (typically 0 or 1 battery)
		for _, b in ipairs(wezterm.battery_info()) do
			table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
		end
		table.insert(cells, window:active_workspace())

		-- The filled in variant of the < symbol
		local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

		-- Color palette for the backgrounds of each cell
		local colors = color_scheme["ansi"]
		-- Foreground color for the text across the fade
		local text_fg = color_scheme["foreground"]

		-- The elements to be formatted
		local elements = {}
		-- How many cells have been formatted
		local num_cells = 0

		-- Translate a cell into elements
		local function push(text, is_last)
			local cell_no = num_cells
			local color_no = math.fmod(cell_no, #colors) + 1
			table.insert(elements, { Foreground = { Color = text_fg } })
			table.insert(elements, { Background = { Color = colors[color_no] } })
			table.insert(elements, { Text = " " .. text .. " " })
			if not is_last then
				table.insert(elements, { Foreground = { Color = colors[color_no + 1] } })
				table.insert(elements, { Text = SOLID_LEFT_ARROW })
			end
			num_cells = num_cells + 1
		end

		table.insert(elements, { Foreground = { Color = colors[1] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })
		while #cells > 0 do
			local cell = table.remove(cells, 1)
			push(cell, #cells == 0)
		end

		window:set_right_status(wezterm.format(elements))
	end)
end

return M
