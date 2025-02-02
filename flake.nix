{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      flake-utils,
      nixpkgs,
      self,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlay = import ./nix/overlay.nix;
        pkgsWithoutOverlay = import nixpkgs {
          system = system;
          config = {
            allowUnfree = true;
          };
        };
        pkgs = pkgsWithoutOverlay.extend overlay;
        core-packages = with pkgs; [
          openmpi
          scotch
          petsc
          # mumps
        ];
        core-python-packages = with pkgs.python313Packages; [
          python
          venvShellHook
          pip
          numpy
          ninja
          mpi4py
          # jax
          # nanobind
        ];
        local-packages = with pkgs; [
          # petsc
          slepc
          tfel
          mgis
          dolfinx-cpp
          # python313Packages.jax
          python313Packages.mpi4py
          python313Packages.petsc4py
          python313Packages.slepc4py
          python313Packages.ufl
          python313Packages.basix
          python313Packages.ffcx
          python313Packages.dolfinx-python
          # python313Packages.dolfinx-materials
        ];
      in
      {
        devShell = pkgs.mkShell {
          venvDir = "./.venv";
          buildInputs = core-packages ++ core-python-packages ++ local-packages;
        };

        legacyPackages = pkgs;
      }
    );
}
