-- Stagecraft OS Desktop Environment
-- By Viktor Nova

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Load Tyrannical Dynamic tagging configuration system
-- This is responsible for making sure apps launch on the
-- correct workspace and obey specific rules
local tyrannical = require("tyrannical")

-- Load user configuration for Tyrannical
local apprules = require("app-rules")

-- Scratchdrop dropdown app (scratchpad) manager
-- local drop      = require("scratchdrop")

-- Load Debian menu entries
-- require("debian.menu")

-- i3-style window layouts
-- local leaved   = require ("awesome-leaved")
-- local treesome = require("treesome")

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
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("~/.config/awesome/stagecraft-os-theme/stagecraft-os-theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "qterminal" or os.getenv("TERMINAL")
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
--   awful.layout.suit.magnifier,
    awful.layout.suit.floating
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

-- {{{ Tags
-- Define a tag table which hold all screen tags.

--tags = {}
--  for s = 1, screen.count() do
  -- Each screen has its own tag table.
--      tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
--    awful.tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, awful.layout[1]) -- awesome-git version
--end


-- }}}

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
mymainmenu= awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })


menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- Create a wibox for each screen and add it
mywibox = {}
mywibox_bottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )



for s = 1, screen.count() do


--  SYSTEM PANELS/BARS (aka "wibox"):

----  TOP BAR ------------------------------------------------------------------
----  TODO: Break this part out into it's own file in a subdirectory
----  TODO: and include all .lua files in that subdirectory.
--
----  TODO: Then use my (to be written) config tool to allow users with low
----  TODO: resources to switch between LxQt top panel and this Awesome panel
----  TODO: which would rename this from panel-top.lua.disabled to panel-top.lua
----  TODO: and disable lxqt-panel through dbus or circusR

-- Awesome-menu configuration
--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                     menu = mymainmenu })

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

--  Create a tasklist widget (taskbar)
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
--  Add the tasklist widget (taskbar)
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.minimizedcurrenttags, mytasklist.buttons)
    mywibox[s] = awful.wibox({ position = "top", ontop = false, screen = s })
--  Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
--  Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
--  right_layout:add(mykeyboardlayout)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
--    right_layout:add(mylayoutbox[s])
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

--  BOTTOM BAR -----------------------------------------------------------------
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(         -- VIKTOR - git version says (layouts, 1), etc
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget for switching between tags/workspaces
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Initialize the bottom bar
    mywibox_bottom[s] = awful.wibox({ position = "bottom", ontop = true, screen = s })
--  NOTE:   A sub-layout that contains other sub-layouts should be set to fixed.
--            Sub-layouts that only contain widgets can be set to 'fixed; or 'align
--          :set_right & :set_left only work on 'align' wibox layouts
--          :add  only works on 'fixed' wibox layouts
--  Left side:
    local bottom_left_layout = wibox.layout.fixed.horizontal()
    --bottom_left_layout:set_left(mytaglist[s])
    bottom_left_layout:add(mytaglist[s])

--  Right side:
    local bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(mypromptbox[s])
    bottom_right_layout:add(mylayoutbox[s])
--    bottom_right_layout:set_right(mylayoutbox[s])
--    bottom_right_layout:set_left(mypromptbox[s])

    local bottom_bar = wibox.layout.align.horizontal()
    bottom_bar:set_left(bottom_left_layout)
    bottom_bar:set_middle()
    bottom_bar:set_right(bottom_right_layout)

--  THIS IS MUCH SIMPLER TO UNDERSTAND(although less flexible):
--    bottom_bar:set_left(mytaglist[s])
--    bottom_bar:set_middle(mypromptbox[s])
--    bottom_bar:set_right(mylayoutbox[s])

    mywibox_bottom[s]:set_widget(bottom_bar)

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

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift" }, "r", awesome.restart),

    -- Viktor disabled the next one since since this is i3's keybinding for 'close window'
    -- and he got tired of accidentally killing X all the time by accident.
    -- Uncomment it if you're an awesome wizard
--  awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts, 1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    -- Dropdown terminal
   -- awful.key({},                    "F12",   function () drop(terminal) end),


    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubarontop
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
--        (which would normally be to add rules in this section)
--
--        Unless you have a special case, you should add your app client rules in app-rules.lua, and not here
--

awful.rules.rules = {
    -- All clients will match this rule.
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
    { rule = { class = "gimp" },
      properties = { floating = true } },

    { rule = { class = "lxqt-panel" },
      properties = { border_width = 0} },
-- VIKTOR:
-- Not sure if this is needed anymore, uncomment it if some floating
-- dialogs are still ending up not on top
--    { rule = { type = "dialog" },                            -- Explicitely set all dialog windows as floating,
--      properties = { floating = true } }

    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}  END OF RULES SECTION
--      Further customization can be added in the SIGNALS section below







-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
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
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
            awful.placement.centered(c,p)
        end

    -- NEVER start a window off-screen
    awful.placement.no_offscreen(c)

    end
    
    

-- ALL FLOATING WINDOWS ARE ON TOP
    if awful.client.floating.get(c) then                     -- Match all new windows that start out floating
      c.ontop = true
    else
      c.ontop = false                                        -- Don't allow non-floating window to start themselves on-top
    end
    
    client.connect_signal("property::floating", function(c)  -- Trigger this function whenever a client's floating state gets changed.
                                                             -- (Dialog windows are set explicitely as floating in the rule above, so they are also included in this rule)
         if awful.client.floating.get(c) then                -- Set client on top if floating is being activated.
           c.ontop = true
         else
           c.ontop = false                                   -- Set client not on top if not floated, or when being "un-floated"
         end
    end)

-- MAXIMIZED CLIENTS GET NO BORDER
    client.connect_signal("property::maximized", function(c)
        if c.maximized then
          c.border_width = 0                                  -- No border if maximized
        else
          c.border_width = beautiful.border_width             -- Put the border back on it
        end
    end)
    

--  AUTO-MINIMIZE ANY INVISIBLE CLIENT (does not work yet)
--  The idea is that any window somehow hidden from view is gets minimized so we can see a button for it on the taskbar
--  I may have my terminology mixed up and need to approach this differently
--      client.connect_signal("property::visible", function(c)   -- Trigger this when any client's visibility changes
--             if awful.client.isvisible() ~= "true" then               -- Match if the client is invisible
--               c.minimized = true
--             else
--             end
--      end)

--  ENABLE SLOPPY FOCUS
--  Not sure what this does, since focus is already 'sloppy'.. leaving it disabled for now
--    client.connect_signal("mouse::enter", function(c)
--        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
--            and awful.client.focus.filter(c) then
--            client.focus = c
--        end
--    end)

--  ENABLE WINDOW DECORATIONS
    local titlebars_enabled = true

--  SETS BEHAVIOR OF CLICK-DRAGGING ON THE TITLEBAR
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
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
--      ATTEMPT TO RESIZE WITH BORDERS (does not work yet)
--      local borders = awful.util.table.join(
--          beautiful.border({ }, 1, function()
--                   client.focus = c
--                   awful.mouse.client.resize(c)
--                   end)
--          )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
--        right_layout:add(awful.titlebar.widget.minimizebutton(c))
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



-- Enable sloppy focus
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus or "#00ffff" end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal or "#000000" end)
-- }}}

-- Autostart the Stagecraft Runit Daemon
-- to daemonize user services
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

run_once("runsvdir","~/SYSTEM/SERVICES/ACTIVE")
run_once("/home/stagecraft/Dev/stagecraft-daemons/global-apps")

--run_once("pidgin",nil,nil,2)
--run_once("wicd-client",nil,"/usr/bin/python2 -O /usr/share/wicd/gtk/wicd-client.py")
