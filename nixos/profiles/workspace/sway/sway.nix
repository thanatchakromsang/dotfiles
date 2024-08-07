{ config, pkgs, lib, ... }:

let
  # https://discourse.nixos.org/t/install-shell-script-on-nixos/6849/10
  # rofi-poweroff = pkgs.writeScriptBin "rofi-poweroff" ''
  #   #!${pkgs.bash}/bin/bash
  #   case $(${pkgs.rofi}/bin/rofi -dmenu << EOF | sed 's/^ *//'
  #   shutdown
  #   reboot
  #   logoff
  #   hibernate
  #   sleep
  #   lock
  #   console
  #   EOF
  #   ) in
  #       "shutdown")
  #           ${pkgs.systemd}/bin/systemctl poweroff
  #           ;;
  #       "reboot")
  #           ${pkgs.systemd}/bin/systemctl reboot
  #           ;;
  #       "hibernate")
  #           ${pkgs.systemd}/bin/systemctl hibernate
  #           ;;
  #       "sleep")
  #           ${pkgs.systemd}/bin/systemctl suspend
  #           ;;
  #       "lock")
  #           ${pkgs.swaylock}/bin/swaylock -f -c 000000
  #           ;;
  #       "logoff")
  #           ${pkgs.sway}/bin/swaymsg exit
  #           ;;
  #   esac
  # '';

          # "--locked XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute";

  toggle-mic = pkgs.writeScriptBin "toggle-mic" ''
    #!${pkgs.bash}/bin/bash
    if [ "$(${pkgs.pamixer}/bin/pamixer --default-source --get-mute)" = "true" ]; then
        exec ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute && echo "0" > /sys/class/leds/platform\:\:micmute/brightness
    else
        exec ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute && echo "1" > /sys/class/leds/platform\:\:micmute/brightness
    fi
  '';
in
{
  programs.sway.enable = true;
  programs.light.enable = true;

  environment.shellAliases = {
    open = "xdg-open";
    pbcopy = "${pkgs.wl-clipboard}/bin/wl-copy";
    pbpaste = "${pkgs.wl-clipboard}/bin/wl-paste";
  };

  home-manager.users.thanatchaya = {
    programs.zsh.loginExtra = ''
      [[ "$(tty)" == /dev/tty1 ]] && sway
    '';

    home.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    home.packages = with pkgs; [
      wl-clipboard
      # nur.repos.reedrw.bitwarden-rofi
    ];

    wayland.windowManager.sway = {
      enable = true;
      checkConfig = false; # NOTE: Workaround for local path mapping from outside NixOS eg. fonts, wallpaper Ref: https://github.com/nix-community/home-manager/issues/5311
      wrapperFeatures.gtk = true;
      /* extraConfig = '' */
      /*   bindsym --input-device=1390:269:ELECOM_TrackBall_Mouse_HUGE_TrackBall --whole-window BTN_EXTRA seat - cursor press BTN_LEFT, seat - cursor release BTN_LEFT */
      /*   bindsym --input-device=1390:269:ELECOM_TrackBall_Mouse_HUGE_TrackBall --whole-window BTN_SIDE seat - cursor press BTN_RIGHT, seat - cursor release BTN_RIGHT */
      /* ''; */
      config = rec {
        modifier = "Mod4";
        workspaceAutoBackAndForth = true;
        fonts = {
          names = [ config.themes.fonts.sansSerif.family ];
          style = "Regular";
          size = 13.0;
        };
        window = {
          titlebar = false;
          hideEdgeBorders = "none";
          commands = [
            {
              criteria = { title = "Firefox — Sharing Indicator"; };
              command = "floating enable, kill";
            }
            {
              criteria = { app_id = "tridactyl_editor"; };
              command = "floating enable";
            }
          ];
        };
        bars = [
          { command = "${pkgs.waybar}/bin/waybar"; }
        ];
        startup = [
          {
            command = ''
              ${pkgs.swayidle}/bin/swayidle -w \
                  timeout 300 '"${pkgs.swaylock}/bin/swaylock" -f -c 000000' \
                  timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
                  before-sleep '"${pkgs.swaylock}/bin/swaylock" -f -c 000000'
            '';
          }
          { command = "${pkgs.mako}/bin/mako --default-timeout 5000 &"; always = true; }
          { command = "${pkgs.keyutils}/bin/keyctl link @u @s"; } # Workaround for bitwarden-rofi https://github.com/NixOS/nixpkgs/issues/95928
        ];
        # swaymsg -t get_inputs
        # read `man 5 sway-input` for more information
        input = {
          # External keyboards
          "12951:18804:ZSA_Technology_Labs_ErgoDox_EZ" = {
            xkb_layout = "colemak_dh_matrix,manoonchai";
            xkb_variant = ",";
            xkb_options = "grp:win_space_toggle";
            repeat_delay = "300";
            repeat_rate = "30";
          };
          "18003:1:foostan_Corne" = {
            xkb_layout = "colemak_dh_matrix,manoonchai";
            xkb_variant = ",";
            xkb_options = "grp:win_space_toggle";
            repeat_delay = "300";
            repeat_rate = "30";
          };
          "4617:8963:Keyboardio_Atreus" = {
            xkb_layout = "colemak_dh_matrix,manoonchai";
            xkb_variant = ",";
            xkb_options = "grp:win_space_toggle";
            repeat_delay = "300";
            repeat_rate = "30";
          };
          # Laptop keyboards
          "1:1:AT_Translated_Set_2_keyboard" = {
            xkb_layout = "us,th";
            xkb_variant = ",";
            xkb_options = "grp:win_space_toggle,caps:escape,ctrl:swap_lalt_lctl";
            repeat_delay = "300";
            repeat_rate = "30";
          };
          # t14s inputs
          "2:14:ETPS/2_Elantech_Touchpad" = {
            accel_profile = "adaptive";
            pointer_accel = "0.2";
            middle_emulation = "enabled";
            natural_scroll = "enabled";
            tap = "enabled";
            dwt = "enabled";
            scroll_factor = "0.5";
            events = "enabled";
          };
          "2:14:ETPS/2_Elantech_TrackPoint" = {
            accel_profile = "adaptive";
            pointer_accel = "0.0";
            dwt = "enabled";
            events = "enabled";
          };
          "1390:269:ELECOM_TrackBall_Mouse_HUGE_TrackBall" = {
            events = "enabled";
            middle_emulation = "enabled";
          };
        };
        seat = {
          "*".hide_cursor = "when-typing enable";
          "seat0".xcursor_theme = "default 48";
        };
        colors =
          let
            color = config.themes.colors;
          in
          {
            background = color.bg;
            focused = {
              text = color.bg1;
              border = color.yellow;
              background = color.yellow;
              childBorder = color.yellow;
              indicator = color.yellow;
            };
            focusedInactive = {
              text = color.bg1;
              border = color.purple;
              background = color.purple;
              childBorder = color.purple;
              indicator = color.purple;
            };
            unfocused = {
              text = color.bg1;
              border = color.gray;
              background = color.gray;
              childBorder = color.gray;
              indicator = color.gray;
            };
            urgent = {
              text = color.bg1;
              border = color.red;
              background = color.red;
              childBorder = color.red;
              indicator = color.red;
            };
          };
        gaps = {
          inner = 5;
          smartGaps = false;
          smartBorders = "off";
        };
        defaultWorkspace = "1";
        workspaceOutputAssign = [ ]; # NOTE: Override in machine configuration
        output = { }; # NOTE: Override in machine configuration
        focus = {
          followMouse = true;
          wrapping = "force";
        };
        keybindings = {
          # Start terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

          # Kill focused window
          "${modifier}+q" = "kill";

          # Start launcher
          "${modifier}+d" = "exec ${pkgs.fuzzel}/bin/fuzzel --width 30 | xargs swaymsg exec --";

          "${modifier}+Shift+r" = "reload";

          # "${modifier}+Shift+e" = "exec ${rofi-poweroff}/bin/rofi-poweroff";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # Switch to workspace
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          # Switch to left/right workspace
          "${modifier}+Tab" = "workspace next_on_output";
          "${modifier}+Shift+Tab" = "workspace prev_on_output";

          # Switch to left/right workspace using [ and ]
          # 0x5b -> [, 0x5d -> ]
          "--to-code ${modifier}+0x5d" = "workspace next_on_output";
          "--to-code ${modifier}+0x5b" = "workspace prev_on_output";

          # Move focused container to workspace
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          # Configure split to match vim configuration
          "${modifier}+v" = "splith";
          "${modifier}+b" = "splitv";

          # Switch the current container between different layout styles
          "${modifier}+s" = "layout stacking";
          "${modifier}+t" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          # Make the current focus fullscreen
          "${modifier}+f" = "fullscreen";

          # Toggle the current focus between tiling and floating mode
          "${modifier}+Shift+space" = "floating toggle";

          # Swap focus between the tiling area and the floating area
          "${modifier}+space" = "focus mode_toggle";

          # Move focus to the parent/child container
          "${modifier}+a" = "focus parent";
          "${modifier}+Shift+a" = "focus child";

          "${modifier}+Shift+z" = "mark z; move scratchpad";
          "${modifier}+Shift+x" = "mark x; move scratchpad";
          "${modifier}+Shift+c" = "move scratchpad";

          # Toggle show scratchpad
          "${modifier}+z" = "[con_mark=z] scratchpad show";
          "${modifier}+x" = "[con_mark=x] scratchpad show";
          "${modifier}+c" = "scratchpad show";

          "--locked XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 3";
          "--locked XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 3";
          "--locked XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute";
          "--locked XF86AudioMicMute" = "exec ${toggle-mic}/bin/toggle-mic";
          "--locked XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "--locked XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "--locked XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "--locked XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "--locked XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -T 1.4";
          "--locked XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -T 0.72";

          "${modifier}+n" = "exec ${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu &";
          "${modifier}+u" = "exec ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth &";
          "${modifier}+y" = "exec ${pkgs.nur.repos.reedrw.bitwarden-rofi}/bin/bwmenu &";

          # Mode binding
          "${modifier}+r" = "mode resize";
          "Print" = "mode 'copy (s) screen, (a) area, (w) window, (o) output to clipboard'";
          "${modifier}+Print" = "mode 'save (s) screen, (a) area, (w) window, (o) output to Pictures'";
          "${modifier}+Shift+e" = "mode 'poweroff (p), reboot (r), suspend (s), lock (l)'";
        };
        modes = {
          resize = {
            "h" = "resize shrink width 20 px";
            "j" = "resize grow height 20 px";
            "k" = "resize shrink height 20 px";
            "l" = "resize grow width 20 px";
            "Left" = "resize shrink width 20 px";
            "Down" = "resize grow height 20 px";
            "Up" = "resize shrink height 20 px";
            "Right" = "resize grow width 20 px";
            "Escape" = "mode default";
            "Return" = "mode default";
          };
          "copy (s) screen, (a) area, (w) window, (o) output to clipboard" = {
            "s" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy screen, mode default";
            "a" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area, mode default";
            "w" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window, mode default";
            "o" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output, mode default";
            "Escape" = "mode default";
            "Return" = "mode default";
          };
          "save (s) screen, (a) area, (w) window, (o) output to Pictures" =
            let
              screenshot_dir = "Pictures/$(date +'%Y-%m-%d+%H:%M:%S').png";
            in
            {
              "s" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save output ${screenshot_dir}, mode default";
              "a" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area ${screenshot_dir}, mode default";
              "w" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save window ${screenshot_dir}, mode default";
              "o" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save output ${screenshot_dir}, mode default";
              "Escape" = "mode default";
              "Return" = "mode default";
            };
          "poweroff (p), reboot (r), suspend (s), lock (l)" =
            {
              "p" = "exec ${pkgs.systemd}/bin/systemctl poweroff, mode default";
              "r" = "exec ${pkgs.systemd}/bin/systemctl reboot, mode default";
              "s" = "exec ${pkgs.systemd}/bin/systemctl suspend, mode default";
              "l" = "exec ${pkgs.swaylock}/bin/swaylock -f -c 000000, mode default";
              "Escape" = "mode default";
              "Return" = "mode default";
            };
        };
      };
    };
  };
}
