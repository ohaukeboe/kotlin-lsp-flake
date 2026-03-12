{
  lib,
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "262.1668.0";

  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-lsp-${version}-linux-x64.zip";
    sha256 = "sha256-jM1vuTsJrKzGOE57LCG8J7KQpo2gRfVLePaZecqNP2w=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/bin $out/lib

    cp -r ${src}/* $out/lib/

    chmod a+x $out/lib/kotlin-lsp.sh
    chmod a+x $out/lib/jre/bin/java

    # Patch the kotlin-lsp.sh script to remove chmod commands
    sed -i '/chmod.*java/d' $out/lib/kotlin-lsp.sh

    ln -s $out/lib/kotlin-lsp.sh $out/bin/kotlin-lsp
  '';

  meta = with lib; {
    description = "Kotlin Language Server";
    homepage = "https://github.com/Kotlin/kotlin-lsp";
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = licenses.asl20;
    mainProgram = "kotlin-lsp";
  };
}
