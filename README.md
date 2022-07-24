# Nix overlay/flake for building latest zig
## Usage
### Standalone
```nix
let
  zig-overlay = import (builtins.fetchGit {
    name = "zig-darwin";
    url = "https://github.com/aiotter/zig-on-nix";
    ref = "refs/heads/latest";
    rev = "242757ed1f85f44539b8afc7c4bfdb6b5b8aed06";
  });
in
import <nixpkgs> { overlays = [ zig-overlay ]; }
```

### configuration.nix
```nix
{ config, pkgs, ... }:
let
  zig-overlay = import (builtins.fetchGit {
    name = "zig-darwin";
    url = "https://github.com/aiotter/zig-on-nix";
    ref = "refs/heads/latest";
    rev = "242757ed1f85f44539b8afc7c4bfdb6b5b8aed06";
  });
in
{
  nixpkgs.overlays = [ zig-overlay ];
  environment.systemPackages = [ pkgs.zig ];
}
```

### flake
```bash
# Install/Run latest stable version of zig
$ nix profile install github:aiotter/zig-on-nix
$ nix run github:aiotter/zig-on-nix

# Install/Run master branch of zig
$ nix profile install 'github:aiotter/zig-on-nix#latest'
$ nix run 'github:aiotter/zig-on-nix#latest'

# Prepare buiding environment for zig
$ nix develop 'github:aiotter/zig-on-nix#latest'
```
