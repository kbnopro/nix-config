{ ... }:
{
  vim.languages.markdown = {
    format.enable = true;
    extraDiagnostics.enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    extensions.markview-nvim = {
      enable = true;
      setupOpts = {
        typst.enable = false;
      };
    };
  };
}
