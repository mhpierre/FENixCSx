{
  stdenv,
  pkgs,
  fetchFromGitHub,
  ps,
  cmake,
  python3,
  tfel,
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
  ];

  propagatedBuildInputs = [
    python3
    pkgs.python312Packages.numpy
    pkgs.python312Packages.boost
    tfel
  ];

  cmakeFlags = [
    "-Denable-python-bindings=ON"
  ];
}
