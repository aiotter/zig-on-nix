self: super:

let
  nixpkgs = import (builtins.fetchGit {
    name = "nixpkgs-unstable-2022-07-15";
    url = "https://github.com/nixos/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "4bc1c1bd2f5b1101443fe775bb737a812fc8b925";
  }) {};
#  apple_sdk = super.callPackage (<nixpkgs> + "/pkgs/os-specific/darwin/apple-sdk-11.0") {};
#  callPackage = if super.stdenv.isDarwin then apple_sdk.callPackage else super.callPackage;
  callPackage = if super.stdenv.isDarwin then nixpkgs.darwin.apple_sdk_11_0.callPackage else super.callPackage;
in
{
  zig = callPackage ./zig.nix {};
}
