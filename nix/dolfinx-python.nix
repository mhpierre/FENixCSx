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
# apple-sdk_12,
# darwinMinVersionHook,
}:

buildPythonPackage rec {
  pname = "dolfinx";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "dolfinx";
    rev = "v${version}";
    hash = "sha256-DYnzl7WI600KuC79ponzuJzr13BucDuRoIdm+U1nxX0=";
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
    # apple-sdk_12
    # (darwinMinVersionHook "12.3")
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
