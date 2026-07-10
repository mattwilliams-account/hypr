---------------------
--- AUTOSTART -------
---------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("nix run ~/nix-dots#lokiNoctalia")
    hl.exec_cmd("hyprctl setcursor Adwaita 24") 
    hl.exec_cmd("noctalia")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 20")
end)
