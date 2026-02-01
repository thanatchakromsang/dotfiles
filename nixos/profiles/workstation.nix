{ config, pkgs, lib, ... }:

let
  inherit (lib) optionals;

  pbcopy = pkgs.writeScriptBin "pbcopy" ''
    #!${pkgs.bash}/bin/bash
    # OSC52 clipboard utility for SSH sessions
    # Usage: echo "text" | pbcopy or pbcopy file.txt

    if [[ $# -eq 0 ]]; then
      # Read from stdin
      content=$(cat)
    else
      # Read from file(s)
      content=$(cat "$@")
    fi

    # Base64 encode the content
    encoded=$(printf '%s' "$content" | ${pkgs.coreutils}/bin/base64)

    # Send OSC52 escape sequence
    printf '\033]52;c;%s\a' "$encoded"
  '';

  pbpaste = pkgs.writeScriptBin "pbpaste" ''
    #!${pkgs.bash}/bin/bash
    # OSC52 clipboard read (not supported over SSH)
    # OSC52 is write-only, so this will fail

    echo "Error: pbpaste is not supported over SSH with OSC52 (OSC52 is write-only)" >&2
    exit 1
  '';
in
{
  imports =
    [
      ./common.nix
      ../users/thanatchaya/base.nix
      ../services/avahi.nix
      ../services/ddc-ci.nix
      ../services/grub.nix
      ../services/dns.nix
    ];

  # programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  services.gnome.gnome-keyring.enable = true;

  networking = {
    networkmanager.enable = true;
    networkmanager.insertNameservers =
      [ ];
    firewall.enable = true;
    firewall.allowPing = true;
  };

  environment.systemPackages = with pkgs; [
    pbcopy
    pbpaste
  ];
}
