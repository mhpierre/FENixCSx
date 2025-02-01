{
  stdenv,
  pkgs,
  fetchFromGitHub,
  ps,
  cmake,
  python313,
  gnuplot,
  lib,
  clang_17, # Cryptic CMAKE error 2 with clang 19
}:

stdenv.mkDerivation {
  pname = "tfel";
  version = "5.0.0";

  src = fetchFromGitHub {
    owner = "thelfer";
    repo = "tfel";
    rev = "TFEL-5.0.0";
    sha256 = "sha256-BTX6dldANIyc1f/fcDYWF1v0DKyq/J0wzP/h3luHfRU=";
  };

  nativeBuildInputs = [
    cmake
    ps
  ] ++ lib.optional stdenv.hostPlatform.isDarwin clang_17;

  propagatedBuildInputs = [
    python313
    pkgs.python313Packages.numpy
    pkgs.python313Packages.boost
    gnuplot
  ];

  cmakeFlags = [
    "-Denable-python-bindings=ON"
    "-Dlocal-castem-header=ON"
  ];
}
