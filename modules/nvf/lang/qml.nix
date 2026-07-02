{ lib, config, ... }:
let
  cfg = config.vim.languages.qml;
in
{
  config = lib.mkIf cfg.enable {
    vim.lsp.servers.qmlls = {
      root_markers = lib.mkAfter [
        ".qmlls.ini"
      ];
    };
    vim.languages.qml = {
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
    # Until Neovim add tree-sitter indentation support for qml
    vim.treesitter.indent.excludes = lib.mkAfter [ "qml" ];
  };
}
