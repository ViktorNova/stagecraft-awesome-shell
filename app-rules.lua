-- APP RULES
-- This is responsible for making sure apps launch on the 
-- correct workspace and obey specific rules. Using this file,
-- you can make certain apps launch minimized, for instance, or
-- cause a normally tiled window to be floating, always on top, etc,
-- or force certain apps (or subwindows of that app) to launch on 
-- specific displays. Many other things are possible than what is seen here

-- For a complete guide covering this powerful module and it's capibilities, 
-- See https://github.com/Elv13/tyrannical

local tyrannical = require("tyrannical")
local awful = require("awful")
local beautiful  = require("beautiful")

-- Setup some tags
tyrannical.tags = {
    {	name	= "  SESSION  ",
        init        = true,                   -- Load the tag on startup
        exclusive   = true,                   -- Refuse any other type of clients (by classes)
        volatile    = false,
        screen      = {1,2},                  -- Create this tag on screen 1 and screen 2
        layout      = awful.layout.suit.tile, -- Use the tile layout
        selected    = true,
        class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
            "Non-Session-Manager"
        }
    } ,
    {	name	= "  PLUGINS  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
      --icon        = "~net.png",                 -- Use this icon for the tag (uncomment with a real path)
        screen      = screen.count()>1 and 2 or 1,-- Setup on screen 2 if there is more than 1 screen, else on screen 1
        layout      = awful.layout.suit.tile,      -- Use the max layout
        class = {
            "Carla", 
            "jalv", 
            "jalv.gtk", 
            "jalv.qt",
            "Calf.gtk", 
            "Mod App",
            "Guitarix",
            "Rackarrack",
            "FKTK Load Sample"     }
    } ,
    {	name 	= "  BEATS  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
        screen      = 1,
        layout      = awful.layout.suit.tile,
        exec_once   = {"dolphin"}, --When the tag is accessed for the first time, execute this command
        class  = {
            "Hydrogen", 
            "drumkv1",
        }
    } ,
    {	name 	= "  SEQ  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
        screen      = 1,
        clone_on    = 2, -- Create a single instance of this tag on screen 1, but also show it on screen 2
                         -- The tag can be used on both screen, but only one at once
        layout      = awful.layout.suit.tile                          ,
        class = { 
            "Los-2014", 
            "Qtractor", 
            "Muse", 
            "LMMS" , 
            "Dino", 
            "Harmony Sequencer",
            "Oomidi",
            "Rosegarden" }
    } ,
    {   name	= "  GLOBAL  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
        layout      = awful.layout.suit.tile,
        instance    = {
            "GLOBAL PLUGINS - GLOBAL PLUGINS.carxp"
        } ,
        class       = {
            "Qmidiroute"
        } ,
    } ,
    {   name	= "  SYSTEM  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
        screen      = 1,
        clone_on    = 2, -- Create a single instance of this tag on screen 1, but also show it on screen 2
                         -- The tag can be used on both screen, but only one at once
        layout      = awful.layout.suit.tile                          ,
        instance    = {
            "lxqt-config"
        } ,
        class = { 
            "lxqt-config", 
            "Cadence" }
    } ,
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
    "LxQt Panel",
    "lxqt-runner", 
    "qterminal",
    "pcmanfm-qt", 
    "gtksu",
    "gsu",
    "Google-chrome",
    "Google-chrome-beta",
    "Google-chrome-unstable",
    "Chromium", 
    "Qupzilla",
    "Paste Special", 
    "Background color"    ,
    "kcolorchooser",
    "plasmoidviewer",
    "Xephyr",
    "kruler",
    "plasmaengineexplorer",
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
    "MPlayer", 
    "pinentry", 
    "ksnapshot", 
    "pinentry", 
    "gtksu",
    "xine", 
    "feh", 
    "kmix", 
    "kcalc", 
    "xcalc",
    "Yakuake", 
    "Select Color$", 
    "kruler", 
    "kcolorchooser", 
    "Paste Special",
    "New Form", 
    "Insert Picture", 
    "kcharselect", 
    "mythfrontend" , 
    "plasmoidviewer" 
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
    "LxQt Panel",
    "Xephyr",
    "Yakuake",
    "ksnapshot",
    "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
    "kcalc"
}

-- Do not honor size hints request for those classes
tyrannical.properties.size_hints_honor = { 
    xterm		= false, 
    URxvt		= false, 
    aterm		= false, 
    sauer_client	= false, 
    mythfrontend	= false
}


-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- }}}
        