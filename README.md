# Dotfiles

My NixOS configuration

- Neovim, kitty and zsh
- Sway (mako, waybar, swaylock, rofi)
- Firefox + preinstalled extension with NUR
- Application Profiles for Development workstation, Server and Client (Grafana, Prometheus, Promtail and Loki)

## NixOS Installation

1. Download and create [NixOS bootable ISO](https://nixos.org/download.html) using flashdrive and `dd`
2. Boot to NixOS
3. Connect Wifi using `wpa`

```bash
export NETWORK_NAME='<SSID>'
export PASSWORD='<REDACTED>'
wpa_passphrase '$NETWORK_NAME' '$PASSWORD' | sudo tee /etc/wpa_supplicant.conf

# Restart wpa
sudo systemctl restart wpa_supplicant.service
```

4. Partition Disk (Example)

```bash
lsblk # check avaliable disk
sudo cfdisk /dev/nvme0n1 # preferred disk
```

Partition disk to following (Thinkpad T14s)

```bash
300MiB EFI System
16GiB Linux Swap
Remaining Linux File System
```

Format disk

```bash
sudo mkfs.fat -F32 /dev/xxx1 # EFI
sudo mkswap /dev/xxx2 # Swap
sudo mkfs.ext4 /dev/xxx3 # Remaining

# Example
sudo mkfs.fat /dev/nvme0n1p1
sudo mkswap /dev/nvme0n1p2
sudo mkfs.ext4 /dev/nvme0n1p3
```

Mount formatted partition to certain directory

```bash
sudo mount /dev/xxx3 /mnt
sudo swapon /dev/xxx2
sudo mkdir -p /mnt/boot
sudo mount /dev/xxx1 /mnt/boot
```

5. Generate default config

```bash
sudo nixos-generate-config --root /mnt # generate default config
```

6. Modify default config to install minimum working solution (select and modify to your need)

```nix
# Add following command to configuration.nix
{
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      devices = ["nodev"];
      enable = true;
      efiSupport = true;
      version = 2;
    };
  };
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  networking.hostName = "canyon"; # Define your hostname.
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    jq
  ];
  users.extraUsers.thanatchaya = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
```

Then run following command and reboot

```bash
nixos-install
```

## Dotfile Installation

connect to WIFI and create password on provisioning machine 

```bash
nmtui # connect to WIFI

passwd thanatchaya
```

rsync from avaliable machine or git clone depending on situation 

```bash
rsync -ah --delete --progress ~/.dotfiles thanatchaya@<destination>:/home/thanatchaya
# git clone https://github.com/thanatchakromsang/dotfiles.git ~/.dotfiles

ssh thanatchaya@<destination>
```

For initial installation we have to copy `hardware-configuration.nix` from provisioning machine to dotfiles and have to create new configuration by copying what's avaliable and modify to your liking

```bash
mkdir ~/.dotfiles/nixos/machines/canyon/
cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/machines/canyon/
```

Then rebuild

```bash
sudo nixos-rebuild switch --flake '.'
```

Import GPG/SSH keys

## Upgrade

Update `flake.lock` and nix install

```bash
# cd ~/.dotfiles/nixos

# nix flake update

$ nixos-rebuild switch --flake .
```
