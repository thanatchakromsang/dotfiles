{ config, pkgs, ... }:

{
  imports =
    [
      ../services/grub.nix
      ../services/ssh.nix
      ../services/ntp.nix
      ../services/dns.nix
      ../services/localization.nix
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
      lazygit
      pet # snippets manager
      unstable.neovim
      zsh-powerlevel10k
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    promptInit = "
      # Add powerlevel10k themes
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Completion
      source ${pkgs.google-cloud-sdk}/google-cloud-sdk/completion.zsh.inc

      bindkey '^ ' autosuggest-accept
      bindkey '^p' up-line-or-beginning-search
      bindkey '^n' down-line-or-beginning-search
      bindkey '^H' backward-kill-word
    ";
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
    r = ". ranger";
    c = "clear";
  };

  system.copySystemConfiguration = true;
}
