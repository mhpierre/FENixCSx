{
  buildPythonPackage,
  fetchPypi,
  mpi4py,
  numpy,
  pip,
  petsc,
  cython,
  mpi,
  clang,
}:

buildPythonPackage rec {
  pname = "petsc4py";
  version = "${petsc.version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-HDZk1bUnNUFxB3yJxLH+899KQb5xltErynSydZx+Jkg=";
  };

  nativeBuildInputs = [
    mpi
  ];

  buildInputs = [
    petsc
    cython
  ];

  propagatedBuildInputs = [
    numpy
    mpi4py
    pip
    clang
  ];

  PETSC_DIR = "${petsc}";

  doCheck = false;

}
