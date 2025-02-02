{
  buildPythonPackage,
  fetchFromGitHub,
  ps,
  blas,
  setuptools,
  numpy,
  pybind11,
  scikit-build-core,
  cmake,
  pathspec,
  pyproject-metadata,
  ufl,
  basix,
  cffi,
}:

buildPythonPackage {

  pname = "ffcx";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "ffcx";
    rev = "v0.9.0";
    hash = "sha256-eAV//RLbrxyhqgbZ2DiR7qML7xfgPn0/Seh+2no0x8w=";
  };

  format = "pyproject";

  nativeBuildInputs = [
    ps
  ];

  buildInputs = [
    blas
  ];

  propagatedBuildInputs = [
    setuptools
    numpy
    pybind11
    scikit-build-core
    cmake
    pathspec
    pyproject-metadata
    ufl
    basix
    cffi
  ];

  dontUseCmakeConfigure = true;
}
