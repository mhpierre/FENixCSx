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
          # mumps
        ];
        core-python-packages = with pkgs.python312Packages; [
          python
          venvShellHook
          pip
          numpy
          ninja
          # mpi4py
          # jax
          nanobind
        ];
        local-packages = with pkgs; [
          petsc
          slepc
          tfel
          mgis
          dolfinx-cpp
          python312Packages.jax
          python312Packages.mpi4py
          python312Packages.petsc4py
          python312Packages.ufl
          python312Packages.basix
          python312Packages.ffcx
          python312Packages.dolfinx-python
          python312Packages.dolfinx-materials
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
