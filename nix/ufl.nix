{ buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
, pip
}:

buildPythonPackage {
  pname = "ufl";
  version = "2024.2.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "ufl";
    rev = "2024.2.0";
    hash = "sha256-YKLTXkN9cIKR545/JRN7zA7dNoVZEVIyO+JaL1V5ajU=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    setuptools
    numpy
    pip
  ];
}
