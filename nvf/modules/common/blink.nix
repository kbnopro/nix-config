{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  config = {
    vim.autocomplete.blink-cmp = {
      enable = true;

      mappings = {
        close = "<C-e>";
        complete = "<C-space>";
        confirm = "<CR>";
        next = "<C-n>";
        previous = "<C-p>";
      };

      setupOpts = {
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };

        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
          menu = {
            draw = {
              treesitter = [ "lsp" ];
            };
          };
        };

        cmdline = {
          enabled = true;
          keymap = {
            preset = "cmdline";
          };
          completion = {
            list = {
              selection = {
                preselect = false;
              };
            };
            menu = {
              auto_show = mkLuaInline ''
                 function(ctx)
                  return vim.fn.getcmdtype() == ":"
                end,
              '';
            };
            ghost_text = {
              enabled = true;
            };
          };
        };
      };
    };

  };
}
