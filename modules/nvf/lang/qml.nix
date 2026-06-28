{ lib, config, ... }:
let
  cfg = config.vim.languages.qml;
in
{
  config = lib.mkIf cfg.enable {
    vim.lsp.servers.qmlls = {
      root_markers = [
        ".git"
        ".qmlls.ini"
      ];
    };
    vim.languages.qml = {
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
