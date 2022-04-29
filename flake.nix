{
  description = "polyglot";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { localSystem = "x86_64-linux"; };
      polyglot = pkgs.stdenv.mkDerivation rec {
        pname = "poly";
        version = "0.5.29";
        src = pkgs.fetchurl {
          url =
            "https://github.com/vmchale/polyglot/releases/download/${version}/poly-x86_64-unknown-linux-gcc-9";
          sha256 = "sha256-Gs6l2toQ6bVh8Af38/TO2SietcZNahk1HY9xc/JtuwY=";
        };
        dontStrip = true;
        unpackPhase = ''
          mkdir -p $out/bin
          cp $src $out/bin/poly
          chmod +x $out/bin/poly
        '';
        dontInstall = true;
      };
    in { defaultPackage."x86_64-linux" = polyglot; };
}
