{
  ...
}:
{
  imports = [
    ./modules
  ];

  config = {
    vim.languages = {
      nix.enable = true;
      python.enable = true;
      typst.enable = true;
    };

    vim.assistant.copilot.enable = true;
  };
}
