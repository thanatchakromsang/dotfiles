{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # General
    codespell
    nerdfix

    # Go
    go
    gopls
    protolint

    # Python
    python315
    pipenv
    poetry
    pyright
    black
    isort
    cookiecutter

    # Javascript / Typescript
    yarn
    nodejs_22
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.eslint_d
    asdf-vm

    # C, C++
    gcc
    gnumake

    # Jsonnet
    go-jsonnet
    jsonnet-bundler

    #
    gh

    # Ops Toolsets
    kubectl
    kubectx
    kubent
    kubernetes-helm
    helm-docs
    kind
    k9s
    k6
    docker-compose

    awscli2

    # Terraform
    tflint
    tenv

    # Development tools
    pre-commit
    redis

    argocd
    cassandra
    vault-bin

    # AI Agentic Coding
    claude-code
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
