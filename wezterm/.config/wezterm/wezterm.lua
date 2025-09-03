-- WezTerm Keybindings Documentation by dragonlobster
-- ===================================================
-- Leader Key:
-- The leader key is set to ALT + q, with a timeout of 2000 milliseconds (2 seconds).
-- To execute any keybinding, press the leader key (ALT + q) first, then the corresponding key.

-- Keybindings:
-- 1. Tab Management:
--    - LEADER + c: Create a new tab in the current pane's domain.
--    - LEADER + x: Close the current pane (with confirmation).
--    - LEADER + b: Switch to the previous tab.
--    - LEADER + n: Switch to the next tab.
--    - LEADER + <number>: Switch to a specific tab (0–9).

-- 2. Pane Splitting:
--    - LEADER + |: Split the current pane horizontally into two panes.
--    - LEADER + -: Split the current pane vertically into two panes.
-- 3. Pane Navigation:
--    - LEADER + h: Move to the pane on the left.
--    - LEADER + j: Move to the pane below.
--    - LEADER + k: Move to the pane above.
--    - LEADER + l: Move to the pane on the right.

-- 4. Pane Resizing:
--    - LEADER + LeftArrow: Increase the pane size to the left by 5 units.
--    - LEADER + RightArrow: Increase the pane size to the right by 5 units.
--    - LEADER + DownArrow: Increase the pane size downward by 5 units.
--    - LEADER + UpArrow: Increase the pane size upward by 5 units.

-- 5. Status Line:
--    - The status line indicates when the leader key is active, displaying an ocean wave emoji (🌊).

-- Miscellaneous Configurations:
-- - Tabs are shown even if there's only one tab.
-- - The tab bar is located at the bottom of the terminal window.
-- - Tab and split indices are zero-based.


-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}
-- Force le rendu logiciel (Software) pour éviter de solliciter le pilote i915
config.front_end = "Software"
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- max fps
config.max_fps = 240
config.animation_fps = 240

--[[
============================
Custom Configuration
============================
]] --

-- Rounded or Square Style Tabs

-- change to square if you don't like rounded tab style
-- local tab_style = "rounded"
local tab_style = "rounded"

-- leader active indicator prefix
local leader_prefix = utf8.char(0x1f30a) -- ocean wave


--[[
============================
Font
============================
]] --

config.font =
    wezterm.font_with_fallback { "Iosevka Term" }
config.font_size = 13

config.window_decorations = "RESIZE"

--[[
--
--
============================
Taille de la fenêtre initiale
============================
]]--
config.initial_cols = 100
config.initial_rows = 50
--[[
============================
Colors
============================
]] --

local color_scheme = "Catppuccin Macchiato"
config.color_scheme = color_scheme

-- color_scheme not sufficient in providing available colors
-- local colors = wezterm.color.get_builtin_schemes()[color_scheme]
config.colors = {
  background = '#1E1E2E' -- <-- Mettez votre code couleur hexadécimal ici
}
-- color scheme colors for easy access
local scheme_colors = {
    catppuccin = {
        macchiato = {
            rosewater = "f4dbd6",
            flamingo = "f0c6c6",
            pink = "f5bde6",
            mauve = "c6a0f6",
            red = "ed8796",
            maroon = "ee99a0",
            peach = "#f5a97f",
            yellow = "#eed49f",
            green = "#a6da95",
            teal = "#8bd5ca",
            sky = "#91d7e3",
            sapphire = "#7dc4e4",
            blue = "#8aadf4",
            lavender = "#b7bdf8",
            text = "#cad3f5",
            crust = "#181926",
            zaatar = "#33261E",
            fancy_pink = "#4911D6",
        }
    }
}

local colors = {
    border = scheme_colors.catppuccin.macchiato.fancy_pink,
    tab_bar_active_tab_fg = scheme_colors.catppuccin.macchiato.lavender,
    tab_bar_active_tab_bg = scheme_colors.catppuccin.macchiato.zaatar,
    tab_bar_text = scheme_colors.catppuccin.macchiato.crust,
    arrow_foreground_leader = scheme_colors.catppuccin.macchiato.lavender,
    arrow_background_leader = scheme_colors.catppuccin.macchiato.zaatar,
}


--[[
============================
Border
============================
]] --

config.window_frame = {
    border_left_width = "0.0cell",
    border_right_width = "0.0cell",
    border_bottom_height = "0.00cell",
    border_top_height = "0.00cell",
    border_left_color = colors.border,
    border_right_color = colors.border,
    border_bottom_color = colors.border,
    border_top_color = colors.border,
}

--[[
============================
Shortcuts
============================
]] --

-- shortcut_configuration
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        mods = "LEADER",
        key = "b",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "LEADER",
        key = "a",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        mods = "LEADER",
        key = "|",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        mods = "LEADER",
        key = "LeftArrow",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        mods = "LEADER",
        key = "RightArrow",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        mods = "LEADER",
        key = "DownArrow",
        action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    {
        mods = "LEADER",
        key = "UpArrow",
        action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
}

for i = 0, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i),
    })
end

--[[
============================
Tab Bar
============================
]] --

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

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

wezterm.on(
    "format-tab-title",
    function(tab, tabs, panes, config, hover, max_width)
        local title = " " .. tab.tab_index .. ": " .. tab_title(tab) .. " "
        local left_edge_text = ""
        local right_edge_text = ""

        if tab_style == "rounded" then
            title = tab.tab_index .. ": " .. tab_title(tab)
            title = wezterm.truncate_right(title, max_width - 2)
            left_edge_text = wezterm.nerdfonts.ple_left_half_circle_thick
            right_edge_text = wezterm.nerdfonts.ple_right_half_circle_thick
        end

        -- ensure that the titles fit in the available space,
        -- and that we have room for the edges.
        -- title = wezterm.truncate_right(title, max_width - 2)

        if tab.is_active then
            return {
                { Background = { Color = colors.tab_bar_active_tab_bg } },
                { Foreground = { Color = colors.tab_bar_active_tab_fg } },
                { Text = left_edge_text },
                { Background = { Color = colors.tab_bar_active_tab_fg } },
                { Foreground = { Color = colors.tab_bar_text } },
                { Text = title },
                { Background = { Color = colors.tab_bar_active_tab_bg } },
                { Foreground = { Color = colors.tab_bar_active_tab_fg } },
                { Text = right_edge_text },
            }
        end
    end
)

--[[
============================
Leader Active Indicator
============================
]] --

wezterm.on("update-status", function(window, _)
    -- leader inactive
    local solid_left_arrow = ""
    local arrow_foreground = { Foreground = { Color = colors.arrow_foreground_leader } }
    local arrow_background = { Background = { Color = colors.arrow_background_leader } }
    local prefix = ""

    -- leaader is active
    if window:leader_is_active() then
        prefix = " " .. leader_prefix

        if tab_style == "rounded" then
            solid_left_arrow = wezterm.nerdfonts.ple_right_half_circle_thick
        else
            solid_left_arrow = wezterm.nerdfonts.pl_left_hard_divider
        end

        local tabs = window:mux_window():tabs_with_info()

        if tab_style ~= "rounded" then
            for _, tab_info in ipairs(tabs) do
                if tab_info.is_active and tab_info.index == 0 then
                    arrow_background = { Foreground = { Color = colors.tab_bar_active_tab_fg } }
                    solid_left_arrow = wezterm.nerdfonts.pl_right_hard_divider
                    break
                end
            end
        end
    end


    window:set_left_status(wezterm.format {
        { Background = { Color = colors.arrow_foreground_leader } },
        { Text = prefix },
        arrow_foreground,
        arrow_background,
        { Text = solid_left_arrow }
    })
end)

-- and finally, return the configuration to wezterm
return config
