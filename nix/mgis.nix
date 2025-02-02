{
  stdenv,
  pkgs,
  fetchFromGitHub,
  ps,
  cmake,
  python313,
  tfel,
}:

stdenv.mkDerivation {
  pname = "mgis";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "thelfer";
    repo = "MFrontGenericInterfaceSupport";
    rev = "MFrontGenericInterfaceSupport-3.0";
    sha256 = "sha256-y8CwoSa3mZ9+kuZPLbQsq/0BJzBA6vhCbFnL3XsLT84=";
  };

  nativeBuildInputs = [
    cmake
    ps
  ];

  propagatedBuildInputs = [
    python313
    pkgs.python313Packages.numpy
    pkgs.python313Packages.boost
    tfel
  ];

  cmakeFlags = [
    "-Wno-dev"
    "-DCMAKE_BUILD_TYPE=Release"
    "-Denable-c-bindings=OFF"
    "-Denable-fortran-bindings=OFF"
    "-Denable-python-bindings=ON"
    "-Denable-portable-build=ON"
    "-Denable-julia-bindings=OFF"
    "-Denable-website=OFF"
    "-Denable-broken-boost-python-module-visibility-handling=ON"
  ];
}
