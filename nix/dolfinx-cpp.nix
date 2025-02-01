{ stdenv
, fetchFromGitHub
, blas
, cmake
, mpi
, pugixml
, boost
, ufl
, basix
, ffcx
, pkg-config
, hdf5-mpi
, scotch
, petsc
, adios2
, spdlog
}:

stdenv.mkDerivation rec {

    pname = "dolfinx";
    version = "0.9.0";

    src = fetchFromGitHub {
        owner = "FEniCS";
        repo = "dolfinx";
        rev = "v0.9.0";
        hash = "sha256-1MM04Z3C3gD2Bb+Emg8PoHmgsXq0n6RkhFdwNlCJSh4=";
    };

    sourceRoot = "${src.name}/cpp";

    nativeBuildInputs = [
        cmake
    ];

    buildInputs = [
        blas
        mpi
        pugixml
        boost
        pkg-config
        hdf5-mpi
        scotch
        spdlog
    ];

    propagatedBuildInputs = [
        ufl
        basix
        ffcx
        petsc
        adios2
    ];

    # cmakeFlags = [
    #     "-DDOLFINX_SKIP_BUILD_TESTS=TRUE"
    # ];

    patches = [
        ./dolfinx.pc.in.patch
    ];
}
