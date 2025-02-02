{ buildPythonPackage
, fetchurl
, clang
, pip
, stdenv
, pkgs
}:

buildPythonPackage {
  pname = "nanobind";
  version = "2.4.0";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/7a/07/abff41fcade3613349eac71dacb166352babef515efd960a751e3175c262/nanobind-2.4.0-py3-none-any.whl";
    sha256 = "sha256-jPJ7BPut653rSnPwK9g4v59+PlqM5ExQyTFCtXKNpYo=";
  };

  buildInputs = [
    pip
  ];

  propagatedBuildInputs = [
    clang
  ];

  nativeBuildInputs = [ pkgs.stdenv ];

  stdenv = pkgs.stdenv // {
      inherit (pkgs.darwin.apple_sdk_12_3) frameworks;
      inherit (pkgs.darwin.apple_sdk.frameworks_12_3) SDKROOT;
    };
}
