{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.vim.languages.coq;

  # To avoid having to open terminal in neovim and compile,
  # we can install coq and coq-lsp in the shell where neovim is launched.
  # myCoq = pkgs.coq_9_0.withPackages (
  #   ps: with ps; [
  #     coq-lsp
  #     stdlib
  #   ]
  # );
in
{
  options = {
    vim.languages.coq = {
      enable = lib.mkEnableOption "Coq support";
    };
  };

  config = lib.mkIf cfg.enable {
    # vim.extraPackages = [
    #   myCoq
    # ];

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
