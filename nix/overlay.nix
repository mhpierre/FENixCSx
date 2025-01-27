final: prev: {
  petsc = final.callPackage ./petsc.nix { };
  # TFEL/MFront
  tfel = final.callPackage ./tfel.nix { };
  adios2 = final.callPackage ./adios2.nix {
    inherit (final.python312Packages) mpi4py;
  };
  dolfinx-cpp = final.callPackage ./dolfinx-cpp.nix {
    inherit (final.python312Packages)
      basix
      ufl
      ffcx
      ;
  };
  # MFrontGenericInterfaceSupport (MGIS)
  mgis = final.callPackage ./mgis.nix { };
  slepc = final.callPackage ./slepc.nix { };
  # scotch = final.callPackage ./scotch.nix { };

  python312 =
    let
      packageOverrides = python-final: python-prev: {
        # Dolfinx-Materials
        dolfinx-materials = python-final.callPackage ./dolfinx-materials.nix { };

        # accessories for FEniCSx
        jax = python-final.callPackage ./jax.nix { };
        mpi4py = python-final.callPackage ./mpi4py.nix { };
        petsc4py = python-final.callPackage ./petsc4py.nix { };
        slepc4py = python-final.callPackage ./slepc4py.nix { };
        nanobind = python-final.callPackage ./nanobind.nix { };

        # FEniCSx components
        ufl = python-final.callPackage ./ufl.nix { };
        basix = python-final.callPackage ./basix.nix { };
        ffcx = python-final.callPackage ./ffcx.nix { };
        dolfinx-python = python-final.callPackage ./dolfinx-python.nix { };
      };
    in
    prev.python312.override { inherit packageOverrides; };

}
