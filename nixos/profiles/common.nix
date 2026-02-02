{ config, pkgs, ... }:


{
  imports =
  [
    ../services/ssh.nix
    ../services/ntp.nix
    ../services/localization.nix

    ./workspace/lazygit.nix
    ./workspace/tmux.nix

    ./applications/neovim.nix
    ./applications/opencode/opencode.nix
  ];

  programs.zsh.enable = true;
}
