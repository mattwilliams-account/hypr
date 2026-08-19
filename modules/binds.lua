---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "pcmanfm"
local menu        = "rofi -show drun -show-icons"
local browser     = "zen"
local screenShot = "flameshot gui --clipboard --path ~/Documents/'Obsidian Vault'/attachments"
---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local secMod = "SHIFT + SUPER"
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call sessionMenu toggle"))
hl.bind(mainMod .. "+ X", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(secMod .. " + s", hl.dsp.exec_cmd(screenShot))

-- fullscreen/floating binds
hl.bind(     -- exclusive fullscreen
    secMod .. " + F",
    hl.dsp.window.fullscreen({ mode = 0 })
)
-- extend width of window to fullscreen
hl.bind(
    mainMod .. " + V",
    hl.dsp.layout("colresize 1.0")
)
-- make width of window half of screen
hl.bind(
    secMod .. " + V",
    hl.dsp.layout("colresize 0.5")
)
-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- move windows around with secMod + arrow keys
hl.bind(secMod .. " + left", hl.dsp.window.move({direction = "l"}))
hl.bind(secMod .. " + right", hl.dsp.window.move({direction = "r"}))
hl.bind(secMod .. " + up", hl.dsp.window.move({direction = "u"}))
hl.bind(secMod .. " + down", hl.dsp.window.move({direction = "down"}))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind(mainMod .. " + M",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Function to toggle maximize and push other windows aside
-- local SNAP_WIDTHS = { 0.333, 0.5, 0.667 }
-- local DEFAULT_WIDTH = 0.5
-- local MOVE_DIR = "move -col" -- change to "move +col" if restore scrolls wrong way
-- local MAX_SCROLL_STEPS = 12
-- local TOL = 0.2

-- local saved = {} -- address -> {width, anchor}

-- local function dims(w) -- get the active monitor's dimesions
--     local mon = w.monitor
--     if not mon then return nil end
--     local mon_x = (mon.position and (mon.position.x or mon.position[1])) or mon.x or 0
--     local mon_w = mon.width or mon.w or (mon.size and (mon.size.x or mon.size[1]))
--     local win_x = (w.at and (w.at.x or w.at[1])) or (w.position and (w.position.x or w.position[1])) or w.x
--     local win_w = w.width or w.w or (w.size and (w.size.x or w.size[1]))
--     if not (mon_w and win_x and win_w) or mon_w == 0 then return nil end
--     return { width = win_w / mon_w, anchor = (win_x - mon_x) / mon_w }
-- end

-- local function snap(width)
--     local best, best_dist = DEFAULT_WIDTH, math.huge
--     for _, v in ipairs(SNAP_WIDTHS) do
--         local d = math.abs(width - v)
--         if d < best_dist then best, best_dist = v, d end
--     end
--     return best
-- end

-- -- to set maximize to toggle back to predifined size instead of saved size add to call arguments toggle_maximize_column(0.66)
-- local function toggle_maximize_column()
--     local w = hl.get_active_window()
--     if w == nil then return end
--     local addr = w.address

--     if addr and saved[addr] then
--         local s = saved[addr]
--         saved[addr] = nil
--         hl.dispatch(hl.dsp.layout("colresize " .. tostring(s.width)))
--         local target = s.anchor or 0
--         if target > TOL then
--             local last = -1
--             for _ = 1, MAX_SCROLL_STEPS do
--                 local cw = hl.get_active_window()
--                 local d = cw and dims(cw)
--                 local cur = d and d.anchor
--                 if not cur or cur >= target - TOL then break end
--                 if math.abs(cur - last) < 0.004 then break end
--                 last = cur
--                 hl.dispatch(hl.dsp.layout(MOVE_DIR))
--             end
--         end
--     else
--         local d = dims(w)
--         if addr then
--             saved[addr] = { width = d and snap(d.width) or DEFAULT_WIDTH, anchor = d and d.anchor or 0 }
--         end
--         hl.dispatch(hl.dsp.layout("colresize 1.0"))
--     end
-- end
-- hl.bind(     -- maximize but not fullscreen
--     mainMod .. " + V",
--     toggle_maximize_column
-- )
