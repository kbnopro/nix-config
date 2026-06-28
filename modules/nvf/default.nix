{
  mylib,
  ...
}:
{
  imports = mylib.scanPaths ./.;

  config = {
    vim.languages = {
      nix.enable = true;
      python.enable = true;
      typst.enable = true;
      clang.enable = true;
      java.enable = true;
      markdown.enable = true;
      go.enable = true;
      coq.enable = true;
      lua.enable = true;
      qml.enable = true;
    };

    vim.assistant.copilot.enable = true;
    vim.presence.neocord.enable = true;
  };
}
