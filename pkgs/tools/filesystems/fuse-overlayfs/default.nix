{ stdenv, fetchFromGitHub, autoreconfHook, pkg-config, fuse3, nixosTests }:

stdenv.mkDerivation rec {
  pname = "fuse-overlayfs";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "containers";
    repo = pname;
    rev = "v${version}";
    sha256 = "00pzwxn5a7dwz9ngl98198lx1c3nlhalzajyqazw9ydjkxibfpay";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];

  buildInputs = [ fuse3 ];

  passthru.tests = { inherit (nixosTests) podman; };

  meta = with stdenv.lib; {
    description = "FUSE implementation for overlayfs";
    longDescription = "An implementation of overlay+shiftfs in FUSE for rootless containers.";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ma9e ] ++ teams.podman.members;
    platforms = platforms.linux;
    inherit (src.meta) homepage;
  };
}
