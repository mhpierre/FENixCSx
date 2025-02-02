# FENixCSx - FEniCSx, MFront/MGIS and dolfinx-materials installed through Nix

## Installation
All necessary packages can be installed using:
```sh
nix develop
```

Experimental features nix-command and flakes must be allowed in Nix.
To enable those experimental features, add the following to `etc/nix/nix.conf`:
```
build-users-group = nixbld
experimental-features = nix-command flakes
```

Some python packages still need to be installed through pip:

```sh
pip install gmsh pyvista notebook jupyterlab ipywidgets trame trame-vtk trame-vuetify
```

Then, you can run the test notebooks for FEniCSx and dolfinx-materials found in `/test` (in `nonlinear_heat_transfer` when importing the MFront library, check the extention - it should be `.so` on linux and `.dylib` on osx)

## Usage
To use `FEniCSx` and other dependencies, always run `nix develop` first to get in the right environment.
