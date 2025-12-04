{
  ...
}: {
  imports = [
    ./config
    ./files.nix
    ./diagnostic.nix

    # If we use nix, we will need nix stuffs!!
    ../lang/nix.nix
  ];
}
