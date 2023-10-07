{ config, pkgs, ... }:


{
  imports =
    [
      ../services/ssh.nix
      ../services/ntp.nix
      ../services/localization.nix

      ./workspace/lazygit.nix

      ./applications/neovim.nix
    ];

  environment.systemPackages = with pkgs;
    [
      git
      rsync
      htop
      wget
      curl
      inetutils
      unzip
      p7zip
      jq
      yq-go
      vim
      exa
      bat
      stow
      fzf
      fd
      gnupg
      age
      ripgrep
      ranger
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
    cat = "${pkgs.bat}/bin/bat";
    grep = "${pkgs.ripgrep}/bin/rg";
    ls = "${pkgs.exa}/bin/exa";
    l = "ls -lFn"; # size,show type,human readable
    la = "ls -lAFn"; # long list,show almost all,show type,human readable
    lt = "ls -ltFh"; # long list,sorted by date,show type,human readable
    ll = "ls -l"; # long list
    ldot = "ls -ld .*";
    k = "${pkgs.kubectl}/bin/kubectl";
    tmp = "vim ~/.tmp.md";
    g = "${pkgs.lazygit}/bin/lazygit";
    r = "ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd $LASTDIR";
    c = "clear";
    ssh = "TERM=xterm-256color ssh";
  };
}
