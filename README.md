# Nix overlay for building zig on macOS
## Usage
### Standalone
```nix
let
  zig-overlay = import (builtins.fetchGit {
    name = "zig-darwin-overlay";
    url = "https://github.com/aiotter/zig-darwin-overlay";
    ref = "refs/heads/master";
    rev = "185422382716191d685a803fa37bb91b89ddb2fc";
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
    rev = "185422382716191d685a803fa37bb91b89ddb2fc";
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
$ nix build github:aiotter/zig-darwin-overlay
$ nix run github:aiotter/zig-darwin-overlay

# Open nix-shell with LLVM14 and other dependencies installed
$ nix develop github:aiotter/zig-darwin-overlay

# With LLVM13 installed (for zig v0.9.1)
$ nix develop 'github:aiotter/zig-darwin-overlay#llvm13'
```
