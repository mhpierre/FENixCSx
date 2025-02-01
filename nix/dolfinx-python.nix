{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  ufl,
  basix,
  ffcx,
  dolfinx-cpp,
  pybind11,
  cmake,
  ps,
  mpi,
  pugixml,
  boost,
  hdf5-mpi,
  pkg-config,
  petsc4py,
  slepc4py,
  petsc,
  cffi,
  certifi,
  zlib,
  nanobind,
  ninja,
  adios2,
  spdlog,
}:

buildPythonPackage rec {
  pname = "dolfinx";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "dolfinx";
    rev = "v${version}";
    hash = "sha256-1MM04Z3C3gD2Bb+Emg8PoHmgsXq0n6RkhFdwNlCJSh4=";
  };

  sourceRoot = "${src.name}/python";

  format = "pyproject";

  nativeBuildInputs = [
    cmake
    ps
    mpi
    pkg-config
  ];

  buildInputs = [
    basix
    dolfinx-cpp
    pugixml
    boost
    hdf5-mpi
    nanobind
    ninja
    spdlog
  ];

  propagatedBuildInputs = [
    setuptools
    numpy
    pybind11
    petsc4py
    slepc4py
    cffi
    certifi
    zlib
    ufl
    basix
    ffcx
    petsc
    adios2
  ];

  patches = [
    ./dolfinx-pyproject.toml.patch
  ];

  dontUseCmakeConfigure = true;

}
