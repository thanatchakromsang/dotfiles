{ config, pkgs, ... }:


{
  imports =
    [
      ../services/grub.nix
      ../services/ssh.nix
      ../services/ntp.nix
      ../services/dns.nix
      ../services/localization.nix

      ./workspace/lazygit.nix
    ];

  environment.systemPackages = with pkgs;
    [
      git
      rsync
      htop
      wget
      curl
      telnet
      unzip
      jq
      yq
      vim
      exa
      bat
      stow
      fzf
      fd
      gnupg
      ripgrep
      ranger
      neovim
      bitwarden-cli
      zsh-powerlevel10k
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 1000000000;
    ohMyZsh = {
      enable = true;
      plugins =
        [
          "git"
          "yarn"
          "docker"
          "node"
          "npm"
          "kubectl"
          "dotenv"
          "wd"
          "fzf"
          "helm"
          "rust"
          "aws"
          "history-substring-search"
        ];
    };
  };

  environment.variables = {
    "EDITOR" = "nvim";
    "VISUAL" = "nvim";
    "FZF_BASE" = "${pkgs.fzf}/share/fzf";
    "FZF_DEFAULT_OPTS" = "--height 40% --border --reverse";
    "FZF_DEFAULT_COMMAND" = "fd --type f --hidden --follow --exclude .git";
  };

  environment.shellAliases = {
    cat = "bat";
    grep = "rg";
    ls = "exa";
    l = "ls -lFn"; # size,show type,human readable
    la = "ls -lAFn"; # long list,show almost all,show type,human readable
    lt = "ls -ltFh"; # long list,sorted by date,show type,human readable
    ll = "ls -l"; # long list
    ldot = "ls -ld .*";
    vim = "nvim";
    k = "kubectl";
    tmp = "vim ~/.tmp.md";
    open = "xdg-open";
    pbcopy = "wl-copy";
    pbpaste = "wl-paste";
    g = "lazygit";
    r = "ranger";
    c = "clear";
  };
}
