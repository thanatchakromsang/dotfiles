{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {};
in
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

    # Lua
    sumneko-lua-language-server

    # General
    unstable.efm-langserver

    # Docker
    nodePackages.dockerfile-language-server-nodejs

    # Vim
    nodePackages.vim-language-server

    # YAML
    unstable.nodePackages.yaml-language-server

    # Ops Toolsets
    unstable.kubectl
    unstable.kubectx
    unstable.kubernetes-helm
    unstable.kind
    unstable.fluxcd
    awscli2
    docker-compose
    google-cloud-sdk

    # Static site generator
    hugo
  ];

  virtualisation.docker = {
    enable = true;
  };
}
