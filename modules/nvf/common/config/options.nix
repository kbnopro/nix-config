{ lib, pkgs, ... }:
let
  inherit (lib.nvim.dag) entryAfter;
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
        # registers = "unnamedplus";
      };

      vim.luaConfigRC.clipboard = entryAfter [ "optionsScript" ] ''
        -- Check if the current session is NOT over SSH
        if not vim.env.SSH_CLIENT and not vim.env.SSH_TTY then
          vim.opt.clipboard = "unnamedplus"
        else
          -- TODO: fix osc52 behaviour for ssh
          vim.g.clipboard = {
            name = 'OSC 52',
            copy = {
              ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
              ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
            },
            paste = {
              -- Override paste functions so Neovim never sends an OSC 52 read request to Zellij
              ['+'] = function() return {} end,
              ['*'] = function() return {} end,
            },
          }
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
