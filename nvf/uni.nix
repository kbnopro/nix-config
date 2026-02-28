{
  ...
}:
{
  imports = [
    ./modules
  ];

  config = {
    vim.languages = {
      typst.enable = true;
    };

    vim.assistant.copilot.enable = true;
  };
}
