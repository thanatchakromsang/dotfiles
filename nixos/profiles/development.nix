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
  ];
}
