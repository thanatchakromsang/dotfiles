{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # Go
    go
    gopls

    # Python
    python39
    python27Full
    pipenv
    nodePackages.pyright

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

    # Terraform
    terraform
    terraform-ls

    # Rust
    rustc
    rustup
    rust-analyzer

    # Jsonnet
    go-jsonnet
    jsonnet-bundler

    # Lua
    sumneko-lua-language-server
    luaformatter

    # General
    unstable.efm-langserver

    # Docker
    nodePackages.dockerfile-language-server-nodejs

    # Vim
    nodePackages.vim-language-server

    # YAML
    unstable.nodePackages.yaml-language-server

    # Nix
    rnix-lsp

    # Ops Toolsets
    unstable.kubectl
    kubectx
    unstable.kubernetes-helm
    unstable.kind
    unstable.fluxcd
    awscli2
    docker-compose
    google-cloud-sdk
    sops
    unstable.cloudflared

    # Static site generator
    hugo
  ];

  virtualisation.docker = {
    enable = true;
  };
}
