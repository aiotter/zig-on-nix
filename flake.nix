{
  description = "Zig for darwin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig = {
      url = "github:ziglang/zig";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, zig }: {
    overlays.default = final: prev: {
      zig = prev.callPackage ./zig.nix { 
        stdenv = if prev.stdenv.isDarwin then prev.darwin.apple_sdk_11_0.stdenv else prev.stdenv;
        llvmPackages = prev.llvmPackages_13;
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; }; in
    rec {
      packages.default = packages."0.9.1";
      packages."0.9.1" = pkgs.zig;

      packages.latest =
        (pkgs.zig.override { llvmPackages = pkgs.llvmPackages_14; })
        .overrideAttrs (_: {
          version = "latest";
          src = pkgs.fetchgit {
            url = "https://github.com/ziglang/zig";
            rev = zig.rev;
            sha256 = zig.narHash;
          };
          # https://github.com/ziglang/zig/issues/12069
          cmakeFlags = [ "-DZIG_STATIC_ZLIB=on" ];
        });
    }
  );
}
