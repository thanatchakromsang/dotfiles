{ config, lib, pkgs, ... }:

let
  fonts = config.themes.fonts;
  colors = config.themes.colors;

  kitty_mod = "ctrl+shift";

  style = ''
    cursor                  ${colors.fg}

    background              ${colors.bg}
    foreground              ${colors.fg0}
    selection_foreground    ${colors.light_gray}
    selection_background    ${colors.fg}

    color0                  ${colors.bg}
    color8                  ${colors.bg4}

    color1                  ${colors.red}
    color9                  ${colors.light_red}

    color2                  ${colors.green}
    color10                 ${colors.light_green}

    color3                  ${colors.yellow}
    color11                 ${colors.light_yellow}

    color4                  ${colors.blue}
    color12                 ${colors.light_blue}

    color5                  ${colors.purple}
    color13                 ${colors.light_purple}

    color6                  ${colors.aqua}
    color14                 ${colors.light_aqua}

    color7                  ${colors.gray}
    color15                 ${colors.fg0}

    active_tab_foreground   ${colors.bg}
    active_tab_background   ${colors.fg3}
    active_tab_font_style   bold

    inactive_tab_foreground ${colors.fg}
    inactive_tab_background ${colors.bg3}
    inactive_tab_font_style normal

    active_border_color     ${colors.aqua}
    inactive_border_color   ${colors.bg3}
  '';
in
{
  home-manager.users.thanatchaya = {
    programs.kitty = {
      enable = true;
      font = {
        name = fonts.sansSerif.family;
        size = fonts.sansSerif.size;
      };
      settings = {
        clear_all_shortcuts = true;
        scrollback_lines = 10000;
        cursor_blink_interval = 0;
        enable_audio_bell = false;
        copy_on_select = true;
        focus_follows_mouse = false;
        hide_window_decorations = true;
      };
      extraConfig = ''
        url_style single

        tab_bar_style separator
        tab_separator ""

        tab_title_template " {index}: {title} {fmt.bold}{'+%s' % (num_windows - 1) if (layout_name == 'stack' and num_windows > 1) else ""} "

        enabled_layouts grid,fat, horizontal, stack, tall, vertical

        scrollback_pager ${pkgs.neovim}/bin/nvim -u NONE -c "set norelativenumber nonumber nolist showtabline=0 foldcolumn=0 laststatus=0" -c "autocmd TermOpen * normal G" -c "vnoremap y myy`y:qa!<CR>" -c "map q :qa!<CR>" -c "map i <nop>" -c "set clipboard+=unnamedplus" -c "silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - "

        mouse_map shift+left release grabbed,ungrabbed mouse_handle_click selection link prompt

        ${style}
      '';
      keybindings = {
        # Keyboard shortcuts
        "${kitty_mod}+c" = "copy_to_clipboard";
        "${kitty_mod}+v" = "paste_from_clipboard";
        "${kitty_mod}+s" = "paste_from_selection";

        # Window management
        "${kitty_mod}+enter" = "new_window_with_cwd";
        "${kitty_mod}+n" = "new_os_window";
        "${kitty_mod}+w" = "close_window";
        "${kitty_mod}+]" = "next_window";
        "${kitty_mod}+[" = "previous_window";
        "${kitty_mod}+f" = "kitten zoom_toggle.py";
        "${kitty_mod}+space" = "next_window";
        "${kitty_mod}+backspace" = "previous_window";

        # Movement management
        "${kitty_mod}+up" = "scroll_line_up";
        "${kitty_mod}+k" = "scroll_line_up";

        "${kitty_mod}+down" = "scroll_line_down";
        "${kitty_mod}+j" = "scroll_line_down";

        "${kitty_mod}+page_up" = "scroll_page_up";
        "${kitty_mod}+page_down" = "scroll_page_down";

        "${kitty_mod}+home" = "scroll_home";
        "${kitty_mod}+end" = "scroll_end";

        # Tab management
        "${kitty_mod}+tab" = "next_tab";
        "${kitty_mod}+t" = "new_tab";
        "${kitty_mod}+q" = "close_tab";
        "${kitty_mod}+." = "set_tab_title";

        # Layout management
        "${kitty_mod}+l" = "next_layout";
        "${kitty_mod}+equal" = "change_font_size all +1.0";
        "${kitty_mod}+minus" = "change_font_size all -1.0";

        # Miscellaneous
        "${kitty_mod}+u" = "kitten unicode_input";
        "${kitty_mod}+/" = "show_scrollback";
      };
    };

    xdg.configFile."kitty/zoom_toggle.py".text = ''
      from kittens.tui.handler import result_handler

      def main(args):
          pass

      @result_handler(no_ui=True)
      def handle_result(args, answer, target_window_id, boss):
          tab = boss.active_tab
          if tab is not None:
              if tab.current_layout.name == 'stack':
                  tab.last_used_layout()
              else:
                  tab.goto_layout('stack')
    '';
  };
}
