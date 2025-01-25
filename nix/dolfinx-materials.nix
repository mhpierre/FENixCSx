{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  petsc4py,
  mpi4py,
  dolfinx-python,
  jax,
}:

buildPythonPackage {
  pname = "dolfinx_materials";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "bleyerj";
    repo = "dolfinx_materials";
    rev = "v0.3.0";
    sha256 = "sha256-xsXOICOxHrKdhqBpXsD1J3QVv8QzfzqhITy5m1cak+U=";
  };

  pyproject = true;

  propagatedBuildInputs = [
    setuptools
    petsc4py
    mpi4py
    dolfinx-python
    jax
  ];
}
