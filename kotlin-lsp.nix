{
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "v0.253.10629";

  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/0.253.10629/kotlin-0.253.10629.zip";
    sha256 = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
    stripRoot=false;
  };

  installPhase = ''
    mkdir -p $out/bin $out/lib

    cp -r ${src}/* $out/lib/

    chmod a+x $out/lib/kotlin-lsp.sh
    ln -s $out/lib/kotlin-lsp.sh $out/bin/kotlin-lsp
  '';
}
