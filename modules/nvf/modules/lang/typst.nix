{ config, lib, ... }:
let
  cfg = config.vim.languages.typst;
in
{
  config = lib.mkIf cfg.enable {
    vim.languages.typst = {
      format = {
        enable = true;
      };
      lsp = {
        enable = true;
      };
      treesitter = {
        enable = true;
      };
      extensions.typst-preview-nvim = {
        enable = true;

      };
    };

    vim.keymaps = [
      {
        key = "<leader>cp";
        mode = "n";
        action = "<CMD>TypstPreviewToggle<CR>";
        desc = "Toggle Typst Preview";
      }
    ];
  };
}
