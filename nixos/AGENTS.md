# AGENTS.md - NixOS Dotfiles

This document provides guidelines for AI agents working with this NixOS dotfiles repository.

## Build Commands

```bash
# Build and switch to new configuration (requires sudo)
sudo nixos-rebuild switch --flake .

# Build for a specific machine
sudo nixos-rebuild switch --flake .#machine-name

# Build only (don't apply)
sudo nixos-rebuild build --flake .

# Dry run to check for errors
sudo nixos-rebuild dry-build --flake .

# Check configuration without building
nix flake check

# Update flake inputs
nix flake update
```

## Code Style Guidelines

### File Structure

```nix
{ config, pkgs, lib, ... }:
```

- All files start with a function signature accepting standard arguments
- Order: `config`, `pkgs`, `lib`, `...` (others as needed)
- Add `inputs` when using flake inputs

### Imports

```nix
imports =
  [
    ./hardware-configuration.nix
    ../../profiles/workstation.nix
    ../../services/ssh.nix
  ];
```

- Use relative paths with `./` for same-level, `../` for parent
- Group imports: hardware, profiles, services, users
- Each import on its own line, list in square brackets
- Align opening bracket with `imports =`

### Indentation & Formatting

- 2 spaces for indentation
- No trailing whitespace
- Align attributes vertically when appropriate

```nix
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
```

### Let Bindings

Define local variables before the main config:

```nix
let
  colors = config.themes.colors;
  fonts = config.themes.fonts;
  toggle-mic = pkgs.writeScriptBin "toggle-mic" ''
    #!${pkgs.bash}/bin/bash
    ...
  '';
in
{
  # configuration
}
```

### Comments

```nix
# Single line comment
# discover/publish *.local hostname on local network
services.avahi.enable = true;

/*
  Multi-line comment
  for longer explanations
*/
```

- Use `#` for single-line comments
- Use `/* */` for multi-line
- Comment above code, not inline

### Package Definitions

```nix
{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "package-name";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "username";
    repo = "repo";
    rev = "hash";
    sha256 = "hash";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp script $out/bin/
  '';

  meta = with lib; {
    description = "Description";
    license = licenses.mit;
    maintainers = with maintainers; [ thanatchaya ];
    platforms = platforms.linux;
  };
}
```

- Use `rec` for recursive bindings
- Include `meta` section with maintainers
- Use `with lib;` in meta for cleaner code

### Attribute Patterns

```nix
environment.systemPackages = with pkgs; [
  git
  vim
  curl
];

environment.shellAliases = {
  ls = "eza";
  grep = "rg";
};
```

- Use `with pkgs;` for package lists
- One package per line in lists
- Group related aliases together

### Home Manager Integration

```nix
home-manager.users.thanatchaya = { pkgs, config, ... }: {
  programs.neovim = {
    enable = true;
  };

  home.file.".config".source = ...;
};
```

- User-specific config under `home-manager.users.<username>`
- Accept `pkgs`, `config`, and `...` in inner lambda
- Use `home.file` or `xdg.configFile` for dotfiles

### Lib Functions

```nix
services.resolved.enable = lib.mkDefault true;
programs.zsh.initContent = lib.mkBefore ''
  content
'';
```

- Use `lib.mkDefault` for overridable defaults
- Use `lib.mkBefore` to prepend content
- Use `lib.mkIf` for conditional inclusion

### String Interpolation

```nix
installPhase = ''
  mkdir -p $out/bin
  cp ${pkgs.bash}/bin/bash $out/bin/
'';

home.sessionVariables = {
  EDITOR = "nvim";
  PATH = "$PATH:/custom/path";
};
```

- Use `''` for multi-line shell strings
- Use `${}` for Nix variable interpolation
- Use `$` for shell variable interpolation (double up `$` in `''` strings)

### Options & Config

```nix
options = {
  themes.colors = lib.mkOption {
    type = lib.types.str;
    default = "#282828";
  };
};

config = {
  themes.colors = "#282828";
};
```

- Define options with `lib.mkOption`
- Set defaults in `config` section
- Use `lib.types` for type checking

### Module Structure

```nix
{ config, lib, pkgs, inputs, ... }:

with lib;
let
  # local definitions
in
{
  imports = [ ./module.nix ];

  options = {
    # option definitions
  };

  config = {
    # actual configuration
  };
}
```

- Use `with lib;` at module level
- Separate `options` and `config` sections
- List imports at top

## Naming Conventions

- **Files**: kebab-case (`keyboard-layout.nix`, `default.nix`)
- **Directories**: kebab-case (`linux-desktop`, `wayland`)
- **Attributes**: camelCase or kebab-case per NixOS conventions
- **Users**: lowercase (`thanatchaya`)
- **Packages**: kebab-case (`rofi-bluetooth`)

## Error Handling

- No explicit error handling in Nix (declarative)
- Use `lib.mkIf` for conditional inclusion
- Use `lib.mkDefault` for fallback values
- Let Nix handle dependency resolution

## Repository Structure

```
.
├── flake.nix          # Main flake definition
├── machines/          # Machine-specific configs
├── modules/           # Reusable modules
├── packages/          # Custom packages
├── profiles/          # Feature profiles
│   ├── applications/  # Application configs
│   └── workspace/     # Desktop environment configs
├── services/          # Service configurations
└── users/             # User-specific configs
```

## Machine Configuration

Each machine has:
- `configuration.nix` - Main config
- `hardware-configuration.nix` - Hardware detection (auto-generated)
- `override.nix` - Machine-specific overrides

Available machines: `t14s`, `canyon`, `militech`

## Common Patterns

### Adding a Package

```nix
environment.systemPackages = with pkgs; [
  new-package
];
```

### Adding a Service

```nix
services.service-name.enable = true;
```

### Adding User Config

Create or update `users/username/profile.nix`:
```nix
{ config, pkgs, lib, ... }:
{
  home-manager.users.username = { ... }: {
    programs.program-name = { ... };
  };
}
```

### Creating a Profile

Add to `profiles/` directory:
```nix
{ config, pkgs, lib, ... }:
{
  imports = [ ];
  
  environment.systemPackages = with pkgs; [ ];
  
  services = { };
}
```

## No Testing

This repository doesn't have automated tests. Validation is performed by:
- `nixos-rebuild dry-build` - Check for syntax errors
- `nix flake check` - Validate flake inputs
- Building and applying the configuration

When making changes, always run a dry build first.
