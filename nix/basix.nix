{
  buildPythonPackage,
  fetchFromGitHub,
  ps,
  ninja,
  blas,
  setuptools,
  numpy,
  pybind11,
  scikit-build-core,
  cmake,
  pathspec,
  pyproject-metadata,
  ufl,
  nanobind,
}:

buildPythonPackage {

  pname = "basix";
  version = "v0.9.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "basix";
    rev = "v0.9.0";
    hash = "sha256-jLQMDt6zdl+oixd5Qevn4bvxBsXpTNcbH2Os6TC9sRQ=";
  };

  format = "pyproject";

  nativeBuildInputs = [
    ps
    ninja
    nanobind
  ];

  buildInputs = [
    blas
    nanobind
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
  ];

  dontUseCmakeConfigure = true;
}
