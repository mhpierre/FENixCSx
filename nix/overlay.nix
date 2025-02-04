final: prev: {

  # Patch mpi shmem error - see when a release > 5.0.6 is on nixpkgs
  mpi = prev.mpi.overrideAttrs (old: {
    patches = [
      (prev.fetchpatch {
        name = "fix-singletons-session-dir";
        url = "https://github.com/open-mpi/ompi/commit/4d4f7212decd0d0ca719688b15dc9b3ee7553a52.patch";
        hash = "sha256-Mb8qXtAUhAQ90v0SdL24BoTASsKRq2Gu8nYqoeSc9DI=";
      })
    ];
  });

  petsc = final.callPackage ./petsc.nix { };
  # petsc = prev.petsc.override {
  #   withParmetis = true;
  #   withScalapack = true;
  #   withMumps = true;
  # };

  slepc = final.callPackage ./slepc.nix { };

  # Fix the "broken" scalapack and mumps from nixpkgs
  scalapack = final.callPackage ./scalapack.nix { };
  mumps = final.callPackage ./mumps.nix { };

  # adios for io in dolfinx
  adios2 = final.callPackage ./adios2.nix {
    inherit (final.python313Packages) mpi4py;
  };

  # dolfinx C++ core
  dolfinx-cpp = final.callPackage ./dolfinx-cpp.nix {
    inherit (final.python313Packages)
      basix
      ufl
      ffcx
      ;
  };

  # TFEL/MFront and MGIS
  tfel = final.callPackage ./tfel.nix { };
  mgis = final.callPackage ./mgis.nix { };

  python313 =
    let
      packageOverrides = python-final: python-prev: {

        # Enable boost-numpy
        boost = python-prev.boost.override { enableNumpy = true; };

        # accessories for FEniCSx
        mpi4py = python-prev.mpi4py.overrideAttrs (old: {
          patches = [ ./mpi4py.test.dlpackimpl.py.patch ];
        });
        # mpi4py = python-final.callPackage ./mpi4py.nix { };
        petsc4py = python-final.callPackage ./petsc4py.nix { };
        slepc4py = python-final.callPackage ./slepc4py.nix { };
        nanobind = python-final.callPackage ./nanobind.nix { };

        # FEniCSx components
        ufl = python-final.callPackage ./ufl.nix { };
        basix = python-final.callPackage ./basix.nix { };
        ffcx = python-final.callPackage ./ffcx.nix { };
        dolfinx-python = python-final.callPackage ./dolfinx-python.nix { };

        # Dolfinx-Materials
        jax = python-final.callPackage ./jax.nix { }; # disabled jax checks taking forever, otherwise stock
        dolfinx-materials = python-final.callPackage ./dolfinx-materials.nix { };
      };
    in
    prev.python313.override { inherit packageOverrides; };

}
