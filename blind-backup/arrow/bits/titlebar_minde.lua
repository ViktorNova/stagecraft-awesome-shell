local theme,path = ...
local surface    = require( "gears.surface"  )
local blind      = require( "blind"          )

local close     = surface(path .."Icon/titlebar_minde/close_normal.png"     )
local ontop     = surface(path .."Icon/titlebar_minde/ontop_normal.png"     )
local sticky    = surface(path .."Icon/titlebar_minde/sticky_normal.png"    )
local floating  = surface(path .."Icon/titlebar_minde/floating_normal.png"  )
local maximized = surface(path .."Icon/titlebar_minde/maximized_normal.png" )
local minimized = surface(path .."Icon/titlebar_minde/minimized_normal.png" )

local active = theme.titlebar_icon_active or theme.titlebar_icon_fg or theme.fg_normal

theme.titlebar = blind {
    close_button = blind {
        normal = surface.tint2(close,"#410000"),
        focus  = surface.tint2(close,"#750000"),
    },

    ontop_button = blind {
        normal_inactive = surface.tint2(ontop,theme.titlebar_icon_fg or theme.fg_normal),
        focus_inactive  = surface.tint2(ontop,theme.titlebar_icon_fg or theme.fg_normal),
        normal_active   = surface.tint2(ontop,active or theme.titlebar_icon_fg or theme.fg_normal),
        focus_active    = surface.tint2(ontop,active or theme.titlebar_icon_fg or theme.fg_normal),
    },

    sticky_button = blind {
        normal_inactive = surface.tint2(sticky,theme.titlebar_icon_fg or theme.fg_normal),
        focus_inactive  = surface.tint2(sticky,theme.titlebar_icon_fg or theme.fg_normal),
        normal_active   = surface.tint2(sticky,active or theme.titlebar_icon_fg or theme.fg_normal),
        focus_active    = surface.tint2(sticky,active or theme.titlebar_icon_fg or theme.fg_normal),
    },

    floating_button = blind {
        normal_inactive = surface.tint2(floating,theme.titlebar_icon_fg or theme.fg_normal),
        focus_inactive  = surface.tint2(floating,theme.titlebar_icon_fg or theme.fg_normal),
        normal_active   = surface.tint2(floating,active or theme.titlebar_icon_fg or theme.fg_normal),
        focus_active    = surface.tint2(floating,active or theme.titlebar_icon_fg or theme.fg_normal),
    },

    maximized_button = blind {
        normal_inactive = surface.tint2(maximized,theme.titlebar_icon_fg or theme.fg_normal),
        focus_inactive  = surface.tint2(maximized,theme.titlebar_icon_fg or theme.fg_normal),
        normal_active   = surface.tint2(maximized,active or theme.titlebar_icon_fg or theme.fg_normal),
        focus_active    = surface.tint2(maximized,active or theme.titlebar_icon_fg or theme.fg_normal),
    },

    resize      = path .."Icon/titlebar/resize.png",
    tag         = path .."Icon/titlebar/tag.png",
    bg_focus    = theme.bg_normal,
    title_align = "left",
    height      = 14,
}