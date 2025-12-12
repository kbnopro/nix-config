{ lib, ... }:
let
  header = [
    "██╗  ██╗██████╗     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
    "██║ ██╔╝██╔══██╗    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
    "█████╔╝ ██████╔╝    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
    "██╔═██╗ ██╔══██╗    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
    "██║  ██╗██████╔╝    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
    "╚═╝  ╚═╝╚═════╝     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
  ];
  inherit (lib.generators) mkLuaInline;

  button =
    {
      sc,
      txt,
      keybind,
      keybind_opts ? {
        noremap = true;
        silent = true;
        nowait = true;
      },
    }:
    let
      sc_ = lib.replaceStrings [ " " ] [ "" ] sc;

      opts = {
        position = "center";
        shortcut = sc;
        cursor = 3;
        width = 50;
        align_shortcut = "right";
        keymap = [
          "n"
          sc_
          keybind
          keybind_opts
        ];
        hl = "AplhaButton";
        hl_shortcut = "AlphaShortcut";
      };
    in
    {
      type = "button";
      val = txt;
      on_press = mkLuaInline ''
        function () 
          local key = vim.api.nvim_replace_termcodes([[${keybind}]] or "${sc_}" .. "<Ignore>", true, false, true)
          vim.api.nvim_feedkeys(key, "t", false)
        end
      '';
      opts = opts;
    };

  buttons = {
    type = "group";
    opts.spacing = 2;
    val = map button [
      {
        sc = "n";
        txt = "  New file";
        keybind = "<cmd> ene <BAR> startinsert <cr>";
      }
      {
        sc = "f";
        txt = "  Find file";
        keybind = "<cmd> lua Snacks.picker.files() <cr>";
      }
      {
        sc = "g";
        txt = "  Find text";
        keybind = "<cmd> lua Snacks.picker.grep() <cr>";
      }
      {
        sc = "s";
        txt = "  Restore Session";
        keybind = ''<cmd> lua require("persistence").load() <cr>'';
      }
      {
        sc = "q";
        txt = "  Quit";
        keybind = ''<cmd> qa <cr>'';
      }
    ];
  };
in
{
  config = {
    vim.dashboard.alpha = {
      enable = true;
      theme = null;
      layout = [
        {
          type = "padding";
          val = 8;
        }

        {
          type = "text";
          val = header;
          opts = {
            position = "center";
          };
        }

        {
          type = "padding";
          val = 3;
        }

        buttons
      ];
    };
  };
}
