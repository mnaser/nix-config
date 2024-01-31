final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (
      python-final: python-prev: {
        black = python-prev.black.overridePythonAttrs (oldAttrs: {
          version = "24.1.2";
        });
      }
    )
  ];
}
