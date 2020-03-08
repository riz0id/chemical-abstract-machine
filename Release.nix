{ ghc-version ? "ghc8101" }:

let
  config = {
    packageOverrides = pkgs: rec {
      haskell = pkgs.haskell // {
        packages = pkgs.haskell.packages // {
          "${ghc-version}" = pkgs.haskell.packages."${ghc-version}".override {
            overrides = haskellPackagesNew: haskellPackagesOld: rec {
              Abstract-Chemical-Machine =
                haskellPackagesNew.callPackage ./Abstract-Chemical-Machine.nix { };
            };
          };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in
  { Abstract-Chemical-Machine =
      pkgs.haskell.packages.${ghc-version}.Abstract-Chemical-Machine;
  }