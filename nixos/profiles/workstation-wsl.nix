{ config, pkgs, lib, ... }:

let
  inherit (lib) optionals;
in
{
  imports =
    [
      ./common.nix
      ../users/thanatchaya/base.nix
    ];

  environment.systemPackages = with pkgs;
    [
      win32yank
    ];

  environment.shellAliases = {
    pbcopy = "${pkgs.win32yank}/bin/win32yank -i --crlf";
    pbpaste = "${pkgs.win32yank}/bin/win32yank -o --lf";
  };

  # XXX: Fix using workaround Ref: https://github.com/NixOS/nixpkgs/issues/102137
  environment.noXlibs = lib.mkForce false;

  # XXX: Fix using workaround Ref: https://github.com/nix-community/NixOS-WSL/issues/185#issuecomment-1367666676
  systemd.services.nixs-wsl-systemd-fix = {
    description = "Fix the /dev/shm symlink to be a mount";
    unitConfig = {
      DefaultDependencies = "no";
      Before = [ "sysinit.target" "systemd-tmpfiles-setup-dev.service" "systemd-tmpfiles-setup.service" "systemd-sysctl.service" ];
      ConditionPathExists = "/dev/shm";
      ConditionPathIsSymbolicLink = "/dev/shm";
      ConditionPathIsMountPoint = "/run/shm";
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.coreutils-full}/bin/rm /dev/shm"
        "/run/wrappers/bin/mount --bind -o X-mount.mkdir /run/shm /dev/shm"
      ];
    };
    wantedBy = [ "sysinit.target" ];
  };

  programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
  services.gnome.gnome-keyring.enable = true;
}

