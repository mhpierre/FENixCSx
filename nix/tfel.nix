{
  stdenv,
  pkgs,
  fetchFromGitHub,
  ps,
  cmake,
  python312,
  gnuplot,
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
    clang_17 # Cryptic CMAKE error 2 with clang 19
  ];

  propagatedBuildInputs = [
    python312
    pkgs.python312Packages.numpy
    pkgs.python312Packages.boost
    gnuplot
  ];

  cmakeFlags = [
    "-Denable-python-bindings=ON"
    "-Dlocal-castem-header=ON"
  ];
}
