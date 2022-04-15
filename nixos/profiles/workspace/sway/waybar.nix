{ config, pkgs, lib, ... }:
let
  colors = config.themes.colors;
  fonts = config.themes.fonts;
  waybar = config.themes.waybar;
  ddcutils-pkgs = "~/.dotfiles/nixos/profiles/workspace/sway/waybar-modules/ddcutil-brightness";
in
{
  themes.waybar = {
    height = 24;
    modules-right = [
      "pulseaudio"
      "network"
      "backlight"
      "battery"
      "sway/language"
      "idle_inhibitor"
    ];
  };

  home-manager.users.thanatchaya = {
    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          height = waybar.height;
          modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
          modules-center = [ "clock" ];
          modules-right = waybar.modules-right;
          "sway/workspaces" = {
            disable-scroll = true;
            format = "{name}:{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              "9" = "";
              "urgent" = "";
              "focused" = "";
              "default" = "";
            };
          };
          "sway/language" = {
            format = "{shortDescription}";
            on-click = "swaymsg input type:keyboard xkb_switch_layout next";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = " {:%b %-d, %Y %H:%M}";
          };
          "backlight" = {
            format = "{percent}%{icon}";
            format-icons = [ "" "" "" "" ];
          };
          "battery" = {
            states = {
              critical = 5;
            };
            format = "{capacity}%{icon}";
            format-charging = "{capacity}%";
            format-critical = "";
            format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
          };
          "network" = {
            format-wifi = "{essid}直";
            format-ethernet = "{ifname}:{ipaddr}/{cidr}";
            format-disconnected = "Disconnected⚠";
            format-alt = "{ifname}:{ipaddr}/{cidr}";
          };
          "pulseaudio" = {
            scroll-step = 1;
            format = "{volume}%{icon} {format_source}";
            format-bluetooth = "{volume}%{icon} {format_source}";
            format-bluetooth-muted = "muted";
            format-source = "{volume}%";
            format-source-muted = "muted";
            format-muted = "muted {format_source}";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" "" ];
            };
            on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute &";
            on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute";
          };
          "disk" = {
            interval = 30;
            format = "{percentage_used}%";
            path = "/";
          };
          "custom/ddcutil" = {
            interval = "once";
            format = " {percentage}%{icon}";
            format-icons = [ "" "" "" "" ];
            exec = "${ddcutils-pkgs} -c";
            on-scroll-up = "${ddcutils-pkgs} -m 1.4; pkill -SIGRTMIN+15 waybar";
            on-scroll-down = "${ddcutils-pkgs} -m 0.72; pkill -SIGRTMIN+15 waybar";
            signal = 15;
            exec-on-event = "true";
            return-type = "json";
          };
        }
      ];
      style = ''
        * {
            border: none;
            border-radius: 0;
            font-family: ${fonts.sansSerif.family};
            font-size: ${toString fonts.sansSerif.size}px;
            min-height: 0;
            box-shadow: none;
            text-shadow: none;
            transition-duration: 0s;
        }
        window#waybar {
          background: ${colors.bg1};
          color: ${colors.fg};
        }

        #workspaces button {
          padding: 0 6px;
          background: transparent;
          color: ${colors.fg};
        }

        #workspaces button.visible {
            background: ${colors.purple};
            color: ${colors.bg};
        }

        #workspaces button.persistent {}

        #workspaces button.current_output {}

        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
        #workspaces button:hover {
            box-shadow: inherit;
            text-shadow: inherit;
        }

        #workspaces button.focused {
            background: ${colors.aqua};
            color: ${colors.bg};
        }

        #workspaces button.urgent {
            background-color: ${colors.red};
        }

        #mode {
            background: ${colors.light_orange};
            color: ${colors.bg};
            padding: 0 4px;
        }

        #battery,
        #cpu,
        #memory,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #tray,
        #language,
        #idle_inhibitor,
        #disk,
        #custom-ddcutil,
        #mpd {
            padding: 0 4px;
            /* margin: 0 4px; */
            color: ${colors.fg};
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        /* If idle_inhibitor is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #idle_inhibitor {
            margin-right: 4px;
        }

        #language {
            min-width: 16px;
        }
      '';
    };
  };
}
