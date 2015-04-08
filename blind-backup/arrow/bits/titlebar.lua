local theme.path = awful.util.getdir("config") .."/arrow/"
local blind      = require( "blind"          )

theme.titlebar = blind {
    close_button = blind {
        normal = path .."Icon/titlebar_minde/close_normal_inactive.png",
        focus = path .."Icon/titlebar_minde/close_focus_inactive.png",
    },

    ontop_button = blind {
        normal_inactive = path .."Icon/titlebar_minde/ontop_normal_inactive.png",
        focus_inactive  = path .."Icon/titlebar_minde/ontop_focus_inactive.png",
        normal_active   = path .."Icon/titlebar_minde/ontop_normal_active.png",
        focus_active    = path .."Icon/titlebar_minde/ontop_focus_active.png",
    },

    sticky_button = blind {
        normal_inactive = path .."Icon/titlebar_minde/sticky_normal_inactive.png",
        focus_inactive  = path .."Icon/titlebar_minde/sticky_focus_inactive.png",
        normal_active   = path .."Icon/titlebar_minde/sticky_normal_active.png",
        focus_active    = path .."Icon/titlebar_minde/sticky_focus_active.png",
    },

    floating_button = blind {
        normal_inactive = path .."Icon/titlebar_minde/floating_normal_inactive.png",
        focus_inactive  = path .."Icon/titlebar_minde/floating_focus_inactive.png",
        normal_active   = path .."Icon/titlebar_minde/floating_normal_active.png",
        focus_active    = path .."Icon/titlebar_minde/floating_focus_active.png",
    },

    maximized_button = blind {
        normal_inactive = path .."Icon/titlebar_minde/maximized_maximized_normal_inactive.png",
        focus_inactive  = path .."Icon/titlebar_minde/maximized_focus_inactive.png",
        normal_active   = path .."Icon/titlebar_minde/maximized_normal_active.png",
        focus_active    = path .."Icon/titlebar_minde/maximized_focus_active.png",
    },

    minimize_button = blind {
        normal_inactive = path .."Icon/titlebar_minde/minimized_normal_inactive.png",
        focus_inactive  = path .."Icon/titlebar_minde/minimized_focus_inactive.png",
        normal_active   = path .."Icon/titlebar_minde/minimized_normal_active.png",
        focus_active    = path .."Icon/titlebar_minde/minimized_focus_active.png",
    },
    
    resize      = path .."Icon/titlebar_minde/resize.png",
    tag         = path .."Icon/titlebar_minde/tag.png",
    bg_focus    = theme.bg_normal,
    title_align = "left",
    height      = 14,
}