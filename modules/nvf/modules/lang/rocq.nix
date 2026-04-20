{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.vim.languages.coq;
in
{
  options = {
    vim.languages.coq = {
      enable = lib.mkEnableOption "Coq support";
    };
  };

  config = lib.mkIf cfg.enable {
    vim.extraPackages = with pkgs.coqPackages; [
      coq-lsp
    ];

    vim.lazy.plugins."coq-lsp.nvim" = {
      enabled = true;
      setupModule = "coq-lsp";
      package = pkgs.vimPlugins.coq-lsp-nvim;
      ft = [ "coq" ];
    };

    vim.lazy.plugins."Coqtail" = {
      enabled = true;
      package = pkgs.vimPlugins.Coqtail;
      ft = [ "coq" ];
      before = ''
        vim.g.loaded_coqtail = 1
        vim.g["coqtail#supported"] = 0
      '';
    };
  };
}
