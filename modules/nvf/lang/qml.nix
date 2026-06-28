{ ... }:
{
  config = {
    vim.lsp.servers.qmlls = {
      root_markers = [
        ".git"
        ".qmlls.init"
      ];
    };
    vim.languages.qml = {
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
