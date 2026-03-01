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
      clang.enable = true;
      java.enable = true;
    };

    vim.assistant.copilot.enable = true;
  };
}
