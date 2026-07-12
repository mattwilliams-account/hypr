require("modules.monitors")
require("modules.binds")
require("modules.autostart")
require("modules.env")
require("modules.windows")
require("modules.apperance")

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- For Noctalia Color templates
require("noctalia").apply_theme()

