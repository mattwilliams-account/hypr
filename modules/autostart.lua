---------------------
--- AUTOSTART -------
---------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 20")
    hl.exec_cmd("udiskie --automount --notify")
end)
