{
  ...
}: {
  imports = [
    ./modules/common
    ./modules/lang
  ];


  config.vim.languages = {
    nix.enable = true;
  };
}
