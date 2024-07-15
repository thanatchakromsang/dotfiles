{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    nerdfix
    # General
    codespell

    # Go
    go
    gopls
    protolint

    # Python
    python3Full
    pipenv
    poetry
    nodePackages.pyright
    black
    isort
    cookiecutter

    # Javascript / Typescript
    yarn
    nodejs_18
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
    # rnix-lsp

    # Ops Toolsets
    kubectl
    kubectx
    kubent
    kubernetes-helm
    kind
    fluxcd
    fluxctl # v1

    awscli2
    ssm-session-manager-plugin

    docker-compose
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    google-cloud-sql-proxy
    kubeseal
    sops
    cloudflared
    k9s
    pulumi-bin
    step-cli
    linkerd
    doctl

    # Terraform
    terraform
    terraform-ls

    # Static site generator
    hugo

    # Database
    dbeaver-bin
    postgresql

    # Network
    dnsutils
  ];

  environment.variables = {
    "USE_GKE_GCLOUD_AUTH_PLUGIN" = "True";
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 20000;
    baseIndex = 1;
    escapeTime = 1; # avoid tmux prints chars on session start in wsl Ref: https://github.com/microsoft/WSL/issues/5931
    newSession = true;
    keyMode = "vi";
    shortcut = "a";
    terminal = "tmux-256color";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.yank
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

      # Enable mouse support
      set-option -g mouse on

      # Enable focus-events
      set-option -g focus-events on

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

      bind-key -r BTab previous-window # Shift tab
      bind-key -r Tab next-window

      # Don't rename windows automatically
      set-window-option -g automatic-rename off
      set-option -g allow-rename off
      set-option -g set-titles on
      set-option -g set-titles-string "#W - #T"
    '';
  };

  virtualisation.docker = {
    enable = true;
  };
}
