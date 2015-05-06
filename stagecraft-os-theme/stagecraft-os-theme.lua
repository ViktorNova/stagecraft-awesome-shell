-- Stagecraft OS Theme
-- Based on Blind "theme.lua" by Elv13


-- {{{ Main
theme = {}
--theme.confdir = awful.util.getdir("config")
--theme.wallpaper_cmd   = { "/usr/bin/nitrogen --restore" }
--theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/zenburn/zenburn-background.png" }
-- }}}

--local path = debug.getinfo(1,"S").source:gsub("themeStagecraft.lua",""):gsub("@","")

------------------------------------------------------------------------------------------------------
--                                                                                                  --
--                                    DEFAULT COLORS, FONT AND SIZE                                 --
--                                                                                                  --
------------------------------------------------------------------------------------------------------

theme.default_height = 14                       -- ????
theme.font           = "Enter Sansman Bold 12"  -- Controls size of all titlebars and desktop bars
--theme.path           = path

-- BAR COLORS
-- These can probably be overwritten, see the comment at the beggining of the next section
theme.bg_normal      = "#000000"
theme.bg_focus       = "#00ffff"
theme.bg_urgent      = "#5B0000"
--theme.bg_minimize    = "#040A1A"
theme.bg_highlight   = "#0E2051"
theme.bg_alternate   = "#0F2766"

theme.fg_normal      = "#00aaff"
theme.fg_focus       = "#000000"
theme.fg_urgent      = "#FF7777"
--theme.fg_minimize    = "#1577D3"

theme.bg_systray     = theme.bg_normal

--theme.border_width  = "1"
--theme.border_normal = "#555555"
--theme.border_focus  = "#535d6c"
--theme.border_marked = "#91231c"

theme.border_width   = "0"
theme.border_width2  = "2"
theme.border_normal  = "#000000"
theme.border_focus   = "#00ffff"
theme.border_marked  = "#ffff00"

--theme.tasklist_plain_task_name     = true


------------------------------------------------------------------------------------------------------
--                                                                                                  --
--                                        TAG AND TASKLIST FUNCTIONS                                --
--                                                                                                  --
------------------------------------------------------------------------------------------------------

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000
--theme.titlebar_bg_focus  = "#00ffff"
--theme.titlebar_fg_focus  = "#000000"



------------------------------------------------------------------------------------------------------
--                                                                                                  --
--                                       TAGLIST/TASKLIST                                           --
--                                                                                                  --
------------------------------------------------------------------------------------------------------

-- Display the taglist squares
theme.taglist_bg_empty           = nil
theme.taglist_bg_selected        = cairo.Pattern.create_for_surface(cairo.ImageSurface.create_from_png(path .."Icon/bg/selected_bg.png"))
theme.taglist_bg_used            = cairo.Pattern.create_for_surface(cairo.ImageSurface.create_from_png(path .."Icon/bg/used_bg.png"))
theme.taglist_bg_urgent          = cairo.Pattern.create_for_surface(cairo.ImageSurface.create_from_png(path .."Icon/bg/urgent_bg.png"))
theme.taglist_bg_remote_selected = cairo.Pattern.create_for_surface(cairo.ImageSurface.create_from_png(path .."Icon/bg/selected_bg_green.png"))
theme.taglist_bg_remote_used     = cairo.Pattern.create_for_surface(cairo.ImageSurface.create_from_png(path .."Icon/bg/used_bg_green.png"))
theme.taglist_bg_hover           = d_mask(blind_pat.sur.flat_grad("#321DBA","#201379",theme.default_height))
theme.taglist_fg_prefix                = theme.bg_normal
-- theme.taglist_squares_unsel            = function(wdg,m,t,objects,idx) return arrow.tag.gen_tag_bg(wdg,m,t,objects,idx,theme.taglist_bg_image_used)     end
-- theme.taglist_squares_sel              = function(wdg,m,t,objects,idx) return arrow.tag.gen_tag_bg(wdg,m,t,objects,idx,theme.taglist_bg_image_selected) end
-- theme.taglist_squares_sel_empty        = function(wdg,m,t,objects,idx) return arrow.tag.gen_tag_bg(wdg,m,t,objects,idx,theme.taglist_bg_image_selected) end
-- theme.taglist_squares_unsel_empty      = function(wdg,m,t,objects,idx) return arrow.tag.gen_tag_bg(wdg,m,t,objects,idx,nil)     end
-- theme.taglist_disable_icon             = false -- ????
-- theme.tasklist_bg_image_normal                  = function(wdg,m,t,objects) return arrow.task.gen_task_bg(wdg,m,t,objects,nil)     end
-- theme.tasklist_bg_image_focus                   = function(wdg,m,t,objects) return arrow.task.gen_task_bg(wdg,m,t,objects,theme.taglist_bg_image_used)     end
-- theme.tasklist_bg_image_urgent                  = function(wdg,m,t,objects) return arrow.task.gen_task_bg(wdg,m,t,objects,theme.taglist_bg_image_urgent)     end
-- theme.tasklist_bg_image_minimize                = function(wdg,m,t,objects) return arrow.task.gen_task_bg(wdg,m,t,objects,nil)     end

theme.tasklist_disable_icon            = false
theme.monochrome_icons                 = true


------------------------------------------------------------------------------------------------------
--                                                                                                  --
--                                               MENU                                               --
--                                                                                                  --
------------------------------------------------------------------------------------------------------


-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
--theme.menu_submenu_icon         = path .."Icon/tags/arrow.png"
--theme.menu_scrollmenu_down_icon = path .."Icon/tags/arrow_down.png"
--theme.menu_scrollmenu_up_icon   = path .."Icon/tags/arrow_up.png"
--theme.awesome_icon              = path .."Icon/awesome2.png"
theme.menu_height               = 20
theme.menu_width                = 130
theme.menu_border_width         = 2
theme.border_width              = 6
theme.border_color              = theme.fg_normal
theme.wallpaper = "~/Pictures/space.jpg"

--theme.dock_icon_color = { type = "linear", from = { 0, 0 }, to = { 0, 55 }, stops = { { 0, "#1889F2" }, { 1, "#083158" }}}

--theme.draw_underlay = themeutils.draw_underlay


---------------  TITLEBAR ---------------------
-- Note this uses ./bits/titlebar_square.lua
-- Further customization can be done there



    --  Titlebar main background:
theme.titlebar.bg.focus    = "00ffff"
    --  Titlebar buttons background:
--theme.titlebar.bg.inactive = "#00000000" -- Button background (ALL windows)
theme.titlebar.bg.active   = "#000211"   -- Pressed button background (ALL windows), close button (inactive window)
      --  hover    = "#cd3b3b",   -- Red X    close button for (current window)
theme.titlebar.bg.hover    = "#ff0062"   -- Dk Pink  close button for (current window)
      --hover    = "#cd3b3b",   -- Red X    close button for (current window)
      --hover    = "#00aaff",   -- Dk Blue  close button for (current window)
theme.titlebar.bg.pressed  = "#000000"    -- ????

    -- Titlebar Buttons blurred border
--theme.titlebar.border_color.inactive = "#00000025" -- Button border  (ALL windows)
    --active   = "#000966", -- Pressed button border (ALL windows), close button border (inactive window)
theme.titlebar.border_color.active   = "#00000050" -- Pressed button border (ALL windows), close button border (inactive window)
theme.titlebar.border_color.hover    = "#00000060" -- Close button border (current window)
theme.titlebar.border_color.pressed  = "#ff0000"    -- ????

    --bg_underlay = { type = "linear", from = { 0, 0 }, to = { 0, default_height }, stops = { { 0, "#3F474E" }, { 1, "#181B1E" }}}, -- This doesn't work at the moment, but it's from themeZilla, so maybe I can port it over

return theme
