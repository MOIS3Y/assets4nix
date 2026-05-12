<div align="center">

# assets4nix

**A collection of curated assets for declarative NixOS & Home Manager configurations**

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&logo=nixos&logoColor=white&labelColor=1e1e2e&color=89b4fa)](https://nixos.org)
[![Flake](https://img.shields.io/badge/Flake-supported-blue.svg?style=for-the-badge&logo=nixos&logoColor=white&labelColor=1e1e2e&color=cba6f7)](https://nixos.wiki/wiki/Flakes)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge&labelColor=1e1e2e&color=a6e3a1)](LICENSE)

</div>

---

## Overview

`assets4nix` is a modular container for system assets (sounds, wallpapers, backgrounds) designed to be easily integrated into Nix configurations. It provides a dynamic NixOS/Home Manager module that automatically maps the file structure to accessible attributes.

## Features

- **Automated Mapping**: Files in `share/` are automatically exposed as attributes in your Nix configuration.
- **Ergonomic Access**: Injected `assets` module argument for direct use in your modules.
- **Architecture Independent**: Static assets handled correctly via FHS-compliant paths in the Nix store.
- **Sanitized Names**: File extensions are automatically stripped from attribute names for cleaner code.

## Structure

The repository follows a stable, extensible structure:

- `share/sounds/`: System, alarm, and notification sounds.
- `share/backgrounds/`: Wallpapers and background images.

Additional categories (icons, fonts, etc.) will be added to `share/` as the collection grows.

## Installation

Add `assets4nix` to your flake inputs:

```nix
inputs = {
  assets4nix.url = "github:MOIS3Y/assets4nix";
};
```

## Usage

### 1. Enable the Module

Import the module in your NixOS or Home Manager configuration:

```nix
{ inputs, ... }: {
  imports = [
    inputs.assets4nix.nixosModules.default # For NixOS
    # or
    inputs.assets4nix.homeManagerModules.default # For Home Manager
  ];

  assets.enable = true;
}
```

### 2. Access Assets

Once enabled, the `assets` attribute is available as a module argument:

```nix
{ assets, ... }: {
  # Example: Setting a wallpaper for Hyprpaper
  services.hyprpaper.settings.wallpaper = [
    ",${assets.backgrounds.my-favorite-wallpaper}"
  ];

  # Example: Configuring a notification sound
  programs.some-app.alertSound = assets.sounds.notification.arpeggio;
}
```

## Licensing

- **Code**: MIT License.
- **Sounds**: Sourced from [Notification Sounds](https://notificationsounds.com/) under [Creative Commons Attribution license](https://notificationsounds.com/terms-of-use#copyright).
- **Images**: Various sources. Please respect original creators' rights if you reuse them.

---
<div align="center">
  Generated with ❤️ for the Nix community
</div>
