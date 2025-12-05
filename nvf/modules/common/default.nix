{
  ...
}: {
  imports = [
    ./config
    ./files.nix
    ./diagnostic.nix
    ./formatter.nix

    # If we use nix, we will need nix stuffs!!
    ../lang/nix.nix
  ];
}
