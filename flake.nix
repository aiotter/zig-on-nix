{
  description = "Zig for darwin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig = {
      url = "github:ziglang/zig/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, zig }:
    flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; }; in rec {
      packages.default = packages.${pkgs.zig.version};
      packages.${pkgs.zig.version} = pkgs.zig;

      packages.latest =
        (pkgs.zig.override { llvmPackages = pkgs.llvmPackages_14; })
        .overrideAttrs (previousAttrs: rec {
          version = "0.9.1-dev.nix+${zig.shortRev}";
          src = zig;
          cmakeFlags = [
            # https://github.com/ziglang/zig/issues/12069
            "-DZIG_STATIC_ZLIB=on"
            "-DZIG_VERSION=${version}"
          ];
        });
    });
}
