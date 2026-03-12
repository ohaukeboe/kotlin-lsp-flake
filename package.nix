{
  lib,
  stdenv,
  fetchzip,
}:

let
  srcs = {
    "x86_64-linux" = {
      urlSuffix = "linux-x64";
      sha256 = "sha256-jM1vuTsJrKzGOE57LCG8J7KQpo2gRfVLePaZecqNP2w=";
    };
    "aarch64-linux" = {
      urlSuffix = "linux-aarch64";
      sha256 = "sha256-JXofBW1dtv6a/AhtU5YIflotwXf1LLJpVU7H6VSlA/U=";
    };
  };
  platformSrc = srcs.${stdenv.hostPlatform.system};
in

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "262.1668.0";

  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-lsp-${version}-${platformSrc.urlSuffix}.zip";
    sha256 = platformSrc.sha256;
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
    license = licenses.unfree;
    mainProgram = "kotlin-lsp";
  };
}
