{ ... }:
{
  config.vim.languages.nix = {
    format = {
      enable = true;
      type = [ "nixfmt" ];
    };
    lsp = {
      enable = true;
    };
    treesitter = {
      enable = true;
    };
  };
}
