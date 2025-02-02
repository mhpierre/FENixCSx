{
  stdenv,
  pkgs,
  fetchFromGitHub,
  ps,
  cmake,
  python313,
  gnuplot,
  gfortran,
}:

stdenv.mkDerivation {
  pname = "tfel";
  version = "5.0.0";

  src = fetchFromGitHub {
    owner = "thelfer";
    repo = "tfel";
    rev = "TFEL-5.0.0";
    sha256 = "sha256-D2fawDaKreBKULplx7wWQ1vWHRsbVCiSUPlaLmWz9VU=";
  };

  nativeBuildInputs = [
    cmake
    gfortran
    ps
    pkgs.python313Packages.boost
  ];

  propagatedBuildInputs = [
    python313
    pkgs.python313Packages.numpy
    gnuplot
  ];

  cmakeFlags = [
    "-Wno-dev"
    "-DCMAKE_BUILD_TYPE=Release"
    "-Dlocal-castem-header=ON"
    "-Denable-fortran=ON"
    "-Denable-aster=ON"
    "-Denable-cyrano=ON"
    "-Denable-python=ON"
    "-Denable-python-bindings=ON"
    "-Denable-numpy-support=ON"
    "-Denable-portable-build=ON"
  ];

  patches = [ ./tfel-fix703.patch ];

}
