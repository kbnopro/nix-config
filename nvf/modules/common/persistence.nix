{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;
in
{
  config = {
    vim.lazy.plugins = {
      "persistence.nvim" = {
        enabled = true;
        package = pkgs.vimPlugins.persistence-nvim;
        event = [ "BufReadPre" ];
        setupModule = "persistence";
        setupOpts = {
          dir = mkLuaInline ''vim.fn.stdpath("state") .. "/sessions/"'';
          need = 1;
          branch = true;
        };
        keys = [
          {
            key = "<leader>qs";
            action = ''function() require("persistence").load() end'';
            desc = "Restore Session";
            lua = true;
            mode = "n";
          }
          {
            key = "<leader>qS";
            action = ''function() require("persistence").select() end'';
            desc = "Select Session";
            lua = true;
            mode = "n";
          }
          {
            key = "<leader>ql";
            action = ''function() require("persistence").load({ last = true }) end'';
            desc = "Restore Last Session";
            lua = true;
            mode = "n";
          }
          {
            key = "<leader>qd";
            action = ''function() require("persistence").stop() end'';
            desc = "Don't save current sessions";
            lua = true;
            mode = "n";
          }
        ];
      };
    };
  };
}
