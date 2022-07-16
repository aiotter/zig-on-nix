{
  description = "Zig building tools for darwin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
      overlays.default = (final: prev:
        let
          stdenv = if prev.stdenv.isDarwin then prev.darwin.apple_sdk_11_0.stdenv else prev.stdenv;
        in {
          zig = prev.callPackage ./zig.nix { inherit stdenv; llvmPackages = prev.llvmPackages_13; };
        });
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in rec {
        packages.default = packages.zig;
        packages.zig = pkgs.zig;

        apps.default = apps.zig;
        apps.zig = flake-utils.lib.mkApp { drv = pkgs.zig; };

        # Defaults to LLVM14, which is required by the latest zig on master branch
        devShells.default = devShells.llvm14;
        devShells.llvm13 = pkgs.zig.override { llvmPackages = pkgs.llvmPackages_13; };
        devShells.llvm14 = pkgs.zig.override { llvmPackages = pkgs.llvmPackages_14; };
      }
    );
}
