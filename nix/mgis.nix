{
  stdenv,
  pkgs,
  fetchFromGitHub,
  ps,
  cmake,
  python312,
  tfel,
  lib,
  clang_17, # Cryptic CMAKE error 2 with clang 19
}:

stdenv.mkDerivation {
  pname = "mgis";
  version = "2.2";

  src = fetchFromGitHub {
    owner = "thelfer";
    repo = "MFrontGenericInterfaceSupport";
    rev = "MFrontGenericInterfaceSupport-2.2";
    sha256 = "sha256-E0GjtCbApGt3vgfFMuNEoNmyyi84R2MH21P9jNU7MgI=";
  };

  nativeBuildInputs = [
    cmake
    ps
  ] ++ lib.optional stdenv.hostPlatform.isDarwin clang_17;

  propagatedBuildInputs = [
    python312
    pkgs.python312Packages.numpy
    pkgs.python312Packages.boost
    tfel
  ];

  cmakeFlags = [
    "-Denable-python-bindings=ON"
  ];
}
