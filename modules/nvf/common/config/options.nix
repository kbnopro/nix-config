{ lib, pkgs, ... }:
let
  inherit (lib.nvim.dag) entryBefore;
in
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
      };

      vim.luaConfigRC.clipboard = entryBefore [ "optionsScript" ] ''
        -- Check if the current session is NOT over SSH
        if not vim.env.SSH_CLIENT and not vim.env.SSH_TTY then
          vim.opt.clipboard = "unnamedplus"
        end
      '';

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

        sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal";
      };
    }
  ];

}
