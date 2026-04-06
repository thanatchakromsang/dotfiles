{ config, pkgs, lib, ... }:
{
  home-manager.users.thanatchaya = { ... }: {
    home.packages = with pkgs; [
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
      typescript
      prettier
      eslint_d
      bun
      asdf-vm

      # C, C++
      gcc
      gnumake
      cmake

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

      # AWS
      awscli2

      # Terraform
      tflint
      tenv

      # Development tools
      pre-commit
      redis

      # ArgoCD
      argocd

      # Vault
      vault-bin
    ];

    home.sessionVariables = {
      USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
    };
  };
}
