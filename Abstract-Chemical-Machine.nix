{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "Abstract-Chemical-Machine";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = false;
  libraryHaskellDepends = [ base ];
  testHaskellDepends = [ base ];
  doHaddock = false;
  license = stdenv.lib.licenses.bsd3;
}
