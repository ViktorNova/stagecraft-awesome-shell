-- Stagecraft OS Desktop Environment
-- By Viktor Nova

-- Standard awesome library
local radical = require("radical")
local awful = require("awful")
awful.rules = require("awful.rules")
local gears = require("gears")
local gears = require("gears")
--local color  = require( "gears.color" )
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful  = require("beautiful")
local blind      = require("blind")

-- Registry module by Elv13
local config     = require( "forgotten"   )

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Load Tyrannical Dynamic tagging configuration system
-- This is responsible for making sure apps launch on the 
-- correct workspace and obey specific rules
local tyrannical = require("tyrannical")
-- Load user configuration for Tyrannical
local apprules = require("app-rules")


-- Load Debian menu entries
 --require("debian.menu")

-- i3-style window layouts
local leaved   = require ("awesome-leaved")
local treesome = require("treesome")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- Themes define colours, icons, font and wallpapers.
--beautiful.init(config.themePath                .. "/themeZilla.lua")
-- Working themes: Holo, SciFi, 
local theme = themeStagecraft
--beautiful.init("~/.config/awesome/blind/arrow/themeStagecraft-SciFi.lua")
--beautiful.init("~/.config/awesome/blind/arrow/themeStagecraft-SciFiGrad.lua")
--beautiful.init("~/.config/awesome/blind/arrow/themeStagecraft-Zilla.lua")
beautiful.init("~/.config/awesome/blind/arrow/themeStagecraft.lua")

-- Load the theme
config.load()
config.themePath = awful.util.getdir("config") .. "/blind/arrow/"
config.iconPath  = config.themePath       .. "Icon/"
beautiful.layout_leaved = os.getenv("HOME") .. "/.config/awesome/stagecraft/icons/leaved.png"

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
--    leaved.layout.suit.tile.right,
--    leaved.layout.suit.tile.left,
--    leaved.layout.suit.tile.bottom,
--    leaved.layout.suit.tile.top,
--    treesome,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
--    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen
--    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- NOTE: Stagecraft OS uses the Tyrannical module to manage screen tags.
-- Do not uncomment this section!! See ~/.config/awesome/app-rules.lua for window rules and tags configuration
-- }}}

-- tags = {}
--    for s = 1, screen.count() do
--       tags[s] = awful.tag({ "DERP 0", "DERP 000","DERP 000", "DERP 000", "DERP 4", "DERP 5", "6 RESEARCH ", "7 STAGECRAFT ", "8 DEV ", "9 WEB "}, s, layouts[1])
--    end

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

-- Add and uncomment the next line to get a Debian menu (doesn't work on Arch, obviously)
 --                                    { "Debian", debian.menu.Debian_menu.Debian },
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }

                                                })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
bar_wibox_top     = {}
bar_wibox_bottom  = {}
mypromptbox       = {}
mylayoutbox       = {}
mytaglist         = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.minimizedcurrenttags, mytasklist.buttons)

    -- Create the wibox
    bar_wibox_top[s]          = awful.wibox({ position = "top", screen = s })
    bar_wibox_bottom[s]   = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout         = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout        = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together:
    --  TOP BAR:
    local top_bar_layout      = wibox.layout.align.horizontal()
        top_bar_layout:set_left(left_layout)
        top_bar_layout:set_right(right_layout)


    -- BOTTOM BAR:
    local bottom_bar_layout  = wibox.layout.align.horizontal()
        bottom_bar_layout:set_middle(mytasklist[s])


    -- Display the bars, now that they have been set up:
    bar_wibox_top[s]:set_widget(top_bar_layout)
    bar_wibox_bottom[s]:set_widget(bottom_bar_layout)
    
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
    
            -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
            
    -- i3-style keybindings for awesome-leaved:
    -- To switch the orientation of the current container use shiftOrder:
    awful.key({ modkey }, "o", leaved.keys.shiftOrder),
    -- To force the current container to split in a certain direction, bind any or all of the following functions:
    awful.key({ modkey, "Shift" }, "h", leaved.keys.splitH), --split next horizontal
    awful.key({ modkey, "Shift" }, "v", leaved.keys.splitV), --split next vertical
    awful.key({ modkey, "Shift" }, "o", leaved.keys.splitOpp), --split in opposing direction
    -- To switch between no tabs, tabs and stack use shiftStyle:
    awful.key({ modkey, "Shift" }, "t", leaved.keys.shiftStyle),
    -- To scale windows there are two options,
    -- use vertical and horizontal scaling and include the percentage points to scale as an argument: 
    awful.key({ modkey, "Shift" }, "]", leaved.keys.scaleV(-5)),
    awful.key({ modkey, "Shift" }, "[", leaved.keys.scaleV(5)),
    awful.key({ modkey }, "]", leaved.keys.scaleH(-5)),
    awful.key({ modkey }, "[", leaved.keys.scaleH(5)),
    -- Or scale based on the focused client and its opposite direction:
    -- focusedScale will always make the current client bigger or smaller in its container
    -- oppositeScale will always scale in the opposing direction.
    awful.key({ modkey, "Shift" }, "]", leaved.keys.scaleOpposite(-5)),
    awful.key({ modkey, "Shift" }, "[", leaved.keys.scaleOpposite(5)),
    awful.key({ modkey }, "]", leaved.keys.scaleFocused(-5)),
    awful.key({ modkey }, "[", leaved.keys.scaleFocused(5)),
    -- To swap two clients in the tree, use swap:
    awful.key({ modkey }, "'", leaved.keys.swap),
    -- To select a client with the keyboard, use focus:
    awful.key({ modkey }, ";", leaved.keys.focus),
    -- or (to allow focusing containers as well)
    awful.key({ modkey }, ";", leaved.keys.focus_container),
    -- To minimize the container of the current client, use min_container:
    awful.key({ modkey, "Shift" }, "n", leaved.keys.min_container),
    -- TODO: Add the mouse actions from https://github.com/michaelbeaumont/awesome-leaved
    
        
            
                    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift" }, "r", awesome.restart),
    -- Viktor disabled the next one since since this is i3's keybinding for 'close window'
    -- and he got tired of accidentally killing X all the time by accident.
    -- Uncomment it if you're an awesome wizard
--    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",
              function(c)
              c.ontop = not c.ontop
              awful.client.floating.toggle()
              end),
    awful.key({ modkey, "Shift"   }, "s", function (c) c.sticky = not c.sticky end),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end),
	-- Rename tag with Mod + F2
	awful.key({ modkey, }, "F2",    function ()
                  awful.prompt.run({ prompt = "Rename workspace: ", text = awful.tag.selected().name, },
                  mypromptbox[mouse.screen].widget,
                  function (s)
                      awful.tag.selected().name = s
                  end)
            end))
end


----------------- Moving / Resizing windows while holding the mod key --------------------
clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 3, awful.mouse.client.resize),
    awful.button({ modkey }, 1,
        function (c)
             c.maximized_horizontal = false -- Un-maximize any window when
             c.maximized_vertical   = false -- it's moved with the Mod key.
             c.maximized            = false
             c.fullscreen           = false
            awful.mouse.client.move(c)
        end)
        )
   
-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{    RULES
--        Rules to apply to new clients (through the "manage" signal).

-- NOTE:  Stagecraft OS manages most of the client rules (rules that match specific windows)
--        through the Tyrannical module, as opposed to the standard Awesome way
--        (which would be to add rules in this section)
--
--        Unless you have a special case, you should add your app client rules in app-rules.lua, and not here
-- 

awful.rules.rules = {
--    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     maximized_vertical   = false,
                     maximized_horizontal = false,
                     maximized            = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
--  { rule = { class = "Qmidiroute" },
--  properties = { floating = true } },

    { rule = { type = "dialog" },                            -- Explicitely set all dialog windows as floating,
      properties = { floating = true } }                     -- so our other floating rules are applied to them

}   -- }}}  END OF RULES SECTION
--          Further customization can be added in the SIGNALS section below

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    
-- All floating windows are on top
    client.connect_signal("property::floating", function(c)  -- Trigger this function whenever a client's floating state gets changed
         if awful.client.floating.get(c) then                -- Set client on top if floating is being activated. 
           c.ontop = true                                    -- Dialog windows are set explicitely as floating in the rule above, so they are also included in this rule
         else                                                -- Set client not on top if being floated
           c.ontop = false
         end
    end)   
    
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)    
    

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)

        -- Windows always start on screen
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
    end

    local titlebars_enabled = true
    if titlebars_enabled  and (c.type == "normal" or c.type == "dialog") then
        local buttons = awful.util.table.join(
                awful.button({ }, 3, function()
                    client.focus = c
                    cfloat = awful.client.floating.get(c)
                    c:raise()
                    c.maximized = false
                        if cfloat == true then      
                            awful.mouse.client.resize(c)  
                        else
                            awful.mouse.client.move(c)
                        end
                    c.maximized = false
                end),
                awful.button({ }, 1, function()
                    client.focus = c
                    cfloat = awful.client.floating.get(c) -- Swap mouse behavior if client is floating or we are in the floating layout
                    c:raise()
                        if cfloat == true or awful.layout.get(c.screen) == awful.layout.suit.floating then
                            awful.mouse.client.move(c)
                        else
                            awful.mouse.client.resize(c)
                        end
                    c.maximized = false
                end)
                )
        -- Attempt to resize with borders
--    local borders = awful.util.table.join(
--                beautiful.border({ }, 1, function()
--                    client.focus = c
--                   awful.mouse.client.resize(c)
--                   end)
--                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.minimizebutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes on the left
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("left")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
