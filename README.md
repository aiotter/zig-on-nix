# Nix overlay for building zig on macOS
## Usage
### Standalone
```nix
let
  zig-overlay = import (builtins.fetchGit {
    name = "zig-darwin-overlay";
    url = "https://github.com/aiotter/zig-darwin-overlay";
    ref = "refs/heads/master";
    rev = "77ed354573fb164641c7240906988a3786d82b43";
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
    rev = "77ed354573fb164641c7240906988a3786d82b43";
  });
in
{
  nixpkgs.overlays = [ zig-overlay ];
  environment.systemPackages = [
    pkgs.zig
  ];
}
```

### flake
```bash
# Install/Run latest stable version of zig
$ nix profile install github:aiotter/zig-darwin-overlay
$ nix run github:aiotter/zig-darwin-overlay

# Install/Run master branch of zig
$ nix profile install 'github:aiotter/zig-darwin-overlay#latest'
$ nix run 'github:aiotter/zig-darwin-overlay#latest'

# Prepare buidling environment for zig
$ nix develop 'github:aiotter/zig-darwin-overlay#latest'
```
