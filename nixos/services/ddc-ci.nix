{ config, pkgs, ... }:

let
  # INFO: https://www.ddcutil.com/i2c_permissions/
  ddcutil-i2c-rules = pkgs.writeTextFile {
    name = "ddcutil-i2c-rules";
    text = ''
      # On some distributions, package i2c-tools provides a udev rule.
      # For example, on Ubuntu, see 40-i2c-tools.rules.

      # Assigns the i2c devices to group i2c, and gives that group RW access:
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"

      # Gives everyone RW access to the /dev/i2c devices:
      # KERNEL=="i2c-[0-9]*",  MODE="0666"
    '';
    destination = "/etc/udev/rules.d/45-ddcutil-i2c.rules";
  };
in
{
  environment.systemPackages = with pkgs;
    [
      ddcui
      ddcutil
    ];
  services.ddccontrol.enable = true;
  hardware.i2c.enable = true;
  services.udev.packages = [
    ddcutil-i2c-rules
  ];
}

