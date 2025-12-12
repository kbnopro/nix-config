{
  mylib,
  ...
}:
{
  vim.utility.snacks-nvim = {
    enable = true;
  };

  imports = mylib.scanPaths ./.;
}
