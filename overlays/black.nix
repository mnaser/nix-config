final: prev:
# Within the overlay we use a recursive set, though I think we can use `final` as well.
rec {
  # nix-shell -p python.pkgs.my_stuff
  python = prev.python.override {
    # Careful, we're using a different final and prev here!
    packageOverrides = final: prev: {
      black = prev.black.overrideAttrs (attrs: {
        version = "24.1.1";
      });
    };
  };
  # nix-shell -p pythonPackages.my_stuff
  pythonPackages = python.pkgs;
}
