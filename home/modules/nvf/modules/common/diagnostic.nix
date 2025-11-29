{ lib, ... }:
{
  config.vim.diagnostics = {
    enable = true;
    config.signs.text = lib.generators.mkLuaInline ''
      {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
      }
    '';
    nvim-lint = {
      enable = true;
      lint_after_save = true;
    };
  };

  config.vim.keymaps = [
    {
      key = "<leader>cd";
      mode = ["n"];
      lua = true;
      action = "vim.diagnostic.open_float";
      desc = "Line Diagnostic";
    }
  ];
}
