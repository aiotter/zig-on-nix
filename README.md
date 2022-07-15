# Nix overlay for building zig on macOS
## Usage
### Standalone
```nix
let
  zig-overlay = import (builtins.fetchGit {
    name = "zig-darwin-overlay";
    url = "https://github.com/aiotter/zig-darwin-overlay";
    ref = "refs/heads/master";
    rev = "e3c91bf4d82eed63cb74496a238fefa906a15bf2";
  });
in
import <nixpkgs> { overlays = [ zig-overlay ]; }
```

### nix-darwin
```nix
{ config, pkgs, ... }:
let
  zig-overlay = import (builtins.fetchGit {
    name = "zig-darwin-overlay";
    url = "https://github.com/aiotter/zig-darwin-overlay";
    ref = "refs/heads/master";
    rev = "e3c91bf4d82eed63cb74496a238fefa906a15bf2";
  });
in
{
  nixpkgs.overlays = [ zig-overlay ];
  environment.systemPackages = [
    pkgs.zig
  ];
}
```
