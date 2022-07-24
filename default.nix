self: super:

let
  flake = builtins.getFlake (toString ./.);
in
{
  zig = flake.packages.${builtins.currentSystem}.default;
}
