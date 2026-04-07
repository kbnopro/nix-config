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
      clang.enable = true;
      java.enable = true;
      markdown.enable = true;
    };

    vim.assistant.copilot.enable = true;
    vim.presence.neocord.enable = true;
  };
}
