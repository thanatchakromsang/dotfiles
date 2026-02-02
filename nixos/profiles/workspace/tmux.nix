{ config, pkgs, lib, ... }:
{
  home-manager.users.thanatchaya = { ... }: {
    programs.tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 20000;
      baseIndex = 1;
      escapeTime = 1;
      newSession = true;
      keyMode = "vi";
      shortcut = "a";
      terminal = "tmux-256color";
      mouse = true;
      focusEvents = true;

      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        # tmuxPlugins.yank
        tmuxPlugins.resurrect
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.tmux-colors-solarized
        tmuxPlugins.fpp
      ];

      extraConfig = ''
        # Improve colors
        set -g default-terminal "tmux-256color"
        set -sg terminal-overrides ",*:RGB"
        set-environment -g COLORTERM "truecolor"

        # # Clipboard settings
        # set -g @yank_selection_mouse 'clipboard'

        set -s set-clipboard on

        # Enable passthrough
        set -g allow-passthrough on

        # Bind Keys
        bind-key Space next-layout
        bind-key : command-prompt
        bind-key ? list-keys
        bind-key c new-window
        bind-key d detach-client
        bind-key "'" choose-window
        bind-key w display-panes
        bind-key , command-prompt -I "rename-window "

        # Split panes
        bind b split-window -v
        bind v split-window -h
        unbind-key %

        bind-key -r BTab previous-window
        bind-key -r Tab next-window

        # Don't rename windows automatically
        set-window-option -g automatic-rename off
        set-option -g allow-rename off
        set-option -g set-titles on
        set-option -g set-titles-string "#W - #T"
      '';
    };
  };
}
