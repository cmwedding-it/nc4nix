# this file is used to figure out which versions of nextcloud we have in nixpkgs
{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  env ? false,
}:
let
  versions = lib.mapAttrsToList (_: v: v.version) (
    lib.filterAttrs (
      k: v: builtins.match "nextcloud[0-9]+" k != null && (builtins.tryEval v.version).success
    ) pkgs
  );
in
if env then lib.concatStringsSep "," versions else versions
