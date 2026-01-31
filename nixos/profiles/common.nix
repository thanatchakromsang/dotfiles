{ config, pkgs, ... }:


{
  imports =
    [
      ../services/ssh.nix
      ../services/ntp.nix
      ../services/localization.nix

      ./workspace/lazygit.nix

      ./applications/neovim.nix
      ./applications/opencode/opencode.nix
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
      eza
      bat
      stow
      fzf
      fd
      gnupg
      ripgrep
      ranger
      bitwarden-cli
      bitwarden-desktop
      zsh-powerlevel10k

      age
      sops
      ssh-to-age
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
    ls = "${pkgs.eza}/bin/eza";
    l = "ls -ln"; # size,show type,human readable
    la = "ls -lAn"; # long list,show almost all,show type,human readable
    lt = "ls -lth"; # long list,sorted by date,show type,human readable
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
