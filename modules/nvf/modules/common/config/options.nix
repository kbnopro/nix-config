{ lib, pkgs, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      vim.clipboard.providers = {
        wl-copy.enable = true;
      };
    })

    {
      vim.clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
    }
    {

      vim.options = {
        # indent stuffs
        autoindent = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        smartindent = true;

        termguicolors = true; # true color

        tm = 300; # wait to finish sequence
        ttimeoutlen = 0;

        wrap = true;
        linebreak = true;
        wrapmargin = 0;
        textwidth = 0;

        undofile = true;
      };
    }

  ];

}
