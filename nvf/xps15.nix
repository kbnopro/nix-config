{
  ...
}:
{
  imports = [
    ./modules/common
    ./modules/lang
  ];

  config.vim.languages = {
    nix.enable = true;
    python.enable = true;
    typst.enable = true;
  };
}
