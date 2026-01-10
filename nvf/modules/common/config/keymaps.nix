{ lib, ... }:
let
  vimKeys = [
    {
      key = "h";
      direction = "Left";
    }
    {
      key = "j";
      direction = "Down";
    }
    {
      key = "k";
      direction = "Up";
    }
    {
      key = "l";
      direction = "Right";
    }
  ];

  betterUp =
    map
      (key: {
        inherit key;
        mode = [
          "n"
          "x"
        ];
        action = "v:count == 0 ? 'gj' : 'j'";
        expr = true;
        desc = "Down";
        silent = true;
      })
      [
        "j"
        "<Down>"
      ];

  betterDown =
    map
      (key: {
        inherit key;
        mode = [
          "n"
          "x"
        ];
        action = "v:count == 0 ? 'gk' : 'k'";
        expr = true;
        desc = "Up";
        silent = true;
      })
      [
        "k"
        "<Up>"
      ];

  betterIndent =
    map
      (key: {
        inherit key;
        mode = "x";
        action = "${key}gv";
      })
      [
        "<"
        ">"
      ];

  clearSearch = {
    mode = [
      "i"
      "n"
      "s"
    ];
    key = "<esc>";
    action = ''
      function()
        vim.cmd("noh")
        return "<esc>"
      end
    '';
    lua = true;
    expr = true;
    desc = "Escape and Clear hlsearch";
  };
in
{
  config.vim.keymaps = lib.flatten [
    betterUp
    betterDown
    betterIndent
    clearSearch
  ];

}
