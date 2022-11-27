{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # General
    codespell

    # Go
    go
    gopls
    protolint

    # Python
    python39
    python27Full
    pipenv
    poetry
    nodePackages.pyright
    black
    python39Packages.isort
    cookiecutter

    # Javascript / Typescript
    yarn
    nodejs-16_x
    nodePackages.typescript
    nodePackages.graphql-cli
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.eslint_d

    # Shell
    shellcheck
    shfmt
    nodePackages.bash-language-server

    # C, C++
    gcc
    gnumake

    # Rust
    rustc
    rustup
    rust-analyzer

    # Jsonnet
    go-jsonnet
    jsonnet-bundler

    # Lua
    sumneko-lua-language-server
    stylua

    # General
    efm-langserver

    # Docker
    nodePackages.dockerfile-language-server-nodejs

    # Vim
    nodePackages.vim-language-server

    # YAML
    nodePackages.yaml-language-server

    # Nix
    rnix-lsp

    # Ops Toolsets
    kubectl
    kubectx
    kubernetes-helm
    kind
    fluxcd
    fluxctl # v1
    awscli2
    docker-compose
    google-cloud-sdk
    cloud-sql-proxy
    kubeseal
    sops
    cloudflared
    k9s
    pulumi-bin
    step-cli
    linkerd

    # Terraform
    terraform
    terraform-ls

    # Static site generator
    hugo

    # Database
    dbeaver
    postgresql

    # Network
    dnsutils
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 20000;
    baseIndex = 1;
    escapeTime = 0;
    newSession = true;
    keyMode = "vi";
    shortcut = "a";
    terminal = "tmux-256color";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.yank
      tmuxPlugins.resurrect
      tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      # Improve colors
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*:Tc"
      set-environment -g COLORTERM "truecolor"

      # Enable mouse support
      set-option -g mouse on

      # Bind Keys
      bind-key Space next-layout
      bind-key : command-prompt
      bind-key ? list-keys
      bind-key c new-window
      bind-key d detach-client
      bind-key "'" choose-window
      bind-key w display-panes
      bind-key , command-prompt -I "rename-window "

      unbind-key z
      bind-key f resize-pane -Z

      # Split panes
      bind b split-window -v
      bind v split-window -h
      unbind-key %

      # Extra Movement aside from C-(h,j,k,l)
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n C-Left if-shell "$is_vim" "send-keys C-Left"  "select-pane -L"
      bind-key -n C-Down if-shell "$is_vim" "send-keys C-Down"  "select-pane -D"
      bind-key -n C-Up if-shell "$is_vim" "send-keys C-Up"  "select-pane -U"
      bind-key -n C-Right if-shell "$is_vim" "send-keys C-Right"  "select-pane -R"
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi C-Up select-pane -U
      bind-key -T copy-mode-vi C-Down select-pane -D
      bind-key -T copy-mode-vi C-Left select-pane -L
      bind-key -T copy-mode-vi C-Right select-pane -R

      bind-key -r BTab previous-window # Shift tab
      bind-key -r Tab next-window

      # Don't rename windows automatically
      set-window-option -g automatic-rename off
      set-option -g allow-rename off
      set-option -g set-titles on
      set-option -g set-titles-string "#W - #T"

      #########################################################
      # Design
      #########################################################

      # This tmux statusbar config was created based on gruvbox colorscheme

      ## COLORSCHEME: gruvbox dark
      set-option -g status on

      # default statusbar colors
      set-option -g status-style fg=colour223,bg=colour237,none
      set-option -g status-left-style none
      set-option -g status-right-style none

      # default window title colors
      set-option -g window-status-style fg=colour237,bg=colour214,none
      set-option -g window-status-activity-style fg=colour248,bg=colour237,bold

      # active window title colors
      set-option -g window-status-current-style fg=colour237,bg=default

      # pane border
      set-option -g pane-active-border-style fg=colour250
      set-option -g pane-border-style fg=colour237

      # message infos
      set-option -g message-style fg=colour223,bg=colour239

      # writing commands inactive
      set-option -g message-command-style fg=colour223,bg=colour239

      # pane number display
      set-option -g display-panes-active-colour colour250 #fg2
      set-option -g display-panes-colour colour237 #bg1

      # clock
      set-window-option -g clock-mode-colour colour109 #blue

      # bell
      set-window-option -g window-status-bell-style fg=colour235,bg=colour167 #bg, red


      ## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
      set-option -g status-justify left
      set-option -g status-left-length 80
      set-option -g status-right-length 80
      set-window-option -g window-status-separator ""

      set-option -g status-left "#[fg=colour248, bg=colour241] #S #[fg=colour241, bg=colour237, nobold, noitalics, nounderscore]"

      set-option -g status-right \
      "#[fg=colour239,bg=colour214]#{?client_prefix, Prefix ,}\
      #[fg=colour246,bg=colour239]#{?pane_in_mode, Copy ,}\
      #[fg=colour237,bg=colour248]#{?window_zoomed_flag, Zoomed ,}\
      #[fg=colour239,bg=colour237,nobold,nounderscore,noitalics]\
      #[fg=colour246,bg=colour239] %Y-%m-%d | %H:%M #[fg=colour248,bg=colour239,nobold,nounderscore,noitalics]\
      #[fg=colour237,bg=colour248] #H "

      set-option -g window-status-format "#[fg=colour237,bg=colour239,noitalics]#[fg=colour223,bg=colour239] #I|#[fg=colour223,bg=colour239]#W #[fg=colour239,bg=colour237,noitalics]"
      set-option -g window-status-current-format "#[fg=colour239,bg=colour214,nobold,nounderscore,noitalics] #[fg=colour239,bg=colour214]#I|#[fg=colour239,bg=colour214,bold]#W #[fg=colour214,bg=colour237,nobold,nounderscore,noitalics]"
    '';
  };

  virtualisation.docker = {
    enable = true;
  };
}
