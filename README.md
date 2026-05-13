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

There are three ways to access assets in your configuration. Choose the one that best fits your style or specific use case.

#### A. Via Module Argument (Recommended)
The module injects `assets` directly into your module arguments. This is the cleanest and most ergonomic way.

```nix
{ assets, ... }: {
  # GNOME Background example
  dconf.settings."org/gnome/desktop/background" = {
    picture-uri = "file://${assets.backgrounds.cat-leaves}";
    picture-uri-dark = "file://${assets.backgrounds.cat-leaves}";
  };
}
```

#### B. Via `config.assets`
Perfect when you need to access assets inside a module that doesn't (or can't) use custom arguments, or when you prefer a more explicit path.

```nix
{ config, ... }: {
  services.hyprpaper.settings = {
    preload = [ "${config.assets.backgrounds.hexagon-grid}" ];
    wallpaper = [ ",${config.assets.backgrounds.hexagon-grid}" ];
  };
}
```

## Attribute Mapping Rules

Assets are mapped based on their location in the `share/` directory:

1.  **Directory Hierarchy**: Subdirectories become nested attributes (e.g., `share/sounds/alarm/` -> `assets.sounds.alarm`).
2.  **Extension Removal**: File extensions are stripped (e.g., `cat-leaves.png` -> `cat-leaves`).
3.  **Clean Keys**: Special characters in filenames are handled by Nix's attribute system.

| File Path | Attribute Path |
| :--- | :--- |
| `share/backgrounds/cat-leaves.png` | `assets.backgrounds.cat-leaves` |
| `share/sounds/notification/glitch.mp3` | `assets.sounds.notification.glitch` |
| `share/sounds/system/case-closed.mp3` | `assets.sounds.system.case-closed` |

## Licensing

- **Code**: MIT License.
- **Sounds**: Sourced from [Notification Sounds](https://notificationsounds.com/) under [Creative Commons Attribution license](https://notificationsounds.com/terms-of-use#copyright).
- **Images**: Various sources. Please respect original creators' rights if you reuse them.

---
<div align="center">
  Generated with ❤️ for the Nix community
</div>
