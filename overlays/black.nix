final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (
      python-final: python-prev: {
        black = python-prev.black.overridePythonAttrs (oldAttrs: rec {
          version = "24.1.1";

          src = oldAttrs.src.override {
            inherit version;
            hash = "sha256-SLV2Dcv+XPl/1PuiOUZoHzqBUUxquKRbUNpnrI+8bHs";
          };
        });
      }
    )
  ];
}
