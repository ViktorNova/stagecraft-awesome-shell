-- APP RULES
-- Stagecraft OS

-- This is responsible for making sure apps launch on the
-- correct workspace and obey specific rules. Using this file,
-- you can make certain apps launch minimized, for instance, or
-- cause a normally tiled window to be floating, always on top, etc,
-- or force certain apps (or subwindows of that app) to launch on 
-- specific displays. Many other things are possible than what is seen here

-- For a complete guide covering this powerful module and it's capibilities, 
-- See https://github.com/Elv13/tyrannical


-- TO DO: make pcmfm-qt desktop show up on all desktops,
-- or find an awesome rule to make "desktop" type windows be sticky


local tyrannical = require("tyrannical")
local awful = require("awful")
local beautiful  = require("beautiful")

-- Default layout for clients with no rules
tyrannical.settings.default_layout = awful.layout.suit.tile

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
        layout      = awful.layout.suit.tile,      -- Use the tile layout
        class = {
            "Carla", 
            "jalv", 
            "jalv.gtk", 
            "jalv.qt",
            "Calf.gtk", 
            "Mod App",
            "Guitarix",
            "Rackarrack",
            "FLTK Load Sample"     }
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
        layout      = awful.layout.suit.tile.bottom,
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
    {   name	= "  MIDI  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
        layout      = awful.layout.suit.tile,
        instance    = { } ,
        class       = {
            "Qmidiroute"
        } ,
    } ,
    {   name	= "  DMX  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
        layout      = awful.layout.suit.magnifier,
        instance    = { } ,
        class       = {
            "Qlcplus"
        } ,
    } ,
    {   name	= "  GLOBAL  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
        layout      = awful.layout.suit.tile,
        instance    = {
            "GLOBAL PLUGINS - GLOBAL PLUGINS.carxp"
        } ,
        class       = { } ,
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
    
    -- These workspaces are not necessarily Stagecraft related,
    -- but Viktor uses them for Stagecraft development, so that's why they are here
    
  {	name	= "  DEV  ",
        init        = false,
        exclusive   = true,
        volatile    = true,
      --icon        = "~net.png",                 -- Use this icon for the tag (uncomment with a real path)
        screen      = 1,
        layout      = awful.layout.suit.tile,      -- Use the tile layout
        class = {
            "Kdevelop", 
            "Kate",
            "QtCreator", 
            "Tea", 
            "juffed",
            "jetbrains-pycharm", 
            "jetbrains-pycharm-ce",
            "jetbrains-pychar", 	    
            "sun-awt-X11-XFramePeer", -- This will probably match lots of Java windows other than PyCharm.. maybe it's ok
            "Gedit",
            "geany"
	}
    },

      {	name	= " WEB1 ",
        init        = false,
        exclusive   = true,
        volatile    = true,
      --icon        = "~net.png",                 -- Use this icon for the tag (uncomment with a real path)
        screen      = 1,
        layout      = awful.layout.suit.tile,      -- Use the tile layout
        class = {
            "Google-chrome"
        }
    },

  {	name	= " REMOTE ",
        init        = false,
        exclusive   = false,
        volatile    = true,
      --icon        = "~net.png",                 -- Use this icon for the tag (uncomment with a real path)
        screen      = 1,
        layout      = awful.layout.suit.tile,      -- Use the tile layout
        class = {
            "X2goclient",
            "X2goagent",
            "Nxplayer.bin"
	}
    },
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
    "lxqt-panel",
    "lxqt-runner", 
    "qterminal",
    "pcmanfm-qt", 
    "Znotes",
    "Xfce4-notes",
    "gtksu",
    "gsu",
--    "Google-chrome",
--    "Google-chrome-stable",
--    "Google-chrome-beta",
--    "Google-chrome-unstable",
--    "Chromium",
--    "Qupzilla",
    "Lightscreen",
    "Copyq",
    "Slickpicker",
    "Qlogout",
    "Paste Special",
    "Background color"    ,
    "kcolorchooser",
    "plasmoidviewer",
    "Xephyr",
    "kruler",
    "plasmaengineexplorer",
    "lxqt-panel"    --LXQT-PANEL
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
    "Znotes",
    "Xfce4-notes",
    "lxqt-runner",
    "lxqt-panel",
    "MPlayer", 
    "pinentry", 
    "ksnapshot", 
    "gtksu",
    "xine", 
    "feh",
    "Lightscreen",
    "Copyq",
    "Slickpicker",
    "Qlogout",
    "kmix", 
    "kcalc", 
    "xcalc","Yakuake", 
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
    "Znotes",
    "Xfce4-notes",
    "lxqt-panel",
    "lxqt-runner",
    "Yakuake",
    "qterminal",
    "ksnapshot",
    "Lightscreen",
    "Copyq",
    "Slickpicker",
    "Qlogout",
    "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
    "Znotes",
    "Xfce4-notes",
    "kcalc"    
}

-- Place the matching clients on all tags
tyrannical.properties.sticky = {
    "lxqt-panel"    --LXQT-PANEL
}

-- Do not honor size hints request for those classes
tyrannical.properties.size_hints_honor = { 
    xterm		= false, 
    URxvt		= false, 
    aterm		= false, 
    sauer_client	= false, 
    mythfrontend	= false
}




-- Set custom border widths for specific clients
--tyrannical.properties.border_width  = {
--    lxqt-panel =   0
--}





------- GLOBAL SETTINGS --------

--Force popups/dialogs to have the same tags as the parent client
tyrannical.settings.group_children  = true 

-- Make all non-normal clients (dock, splash) intrusive
force_odd_as_intrusive              = true

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- }}}
        
