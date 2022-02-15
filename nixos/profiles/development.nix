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
    luaformatter

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
    nodePackages.cdktf-cli

    # Static site generator
    hugo

    # Database
    dbeaver
    postgresql

    # Network
    dnsutils
  ];

  virtualisation.docker = {
    enable = true;
  };
}
