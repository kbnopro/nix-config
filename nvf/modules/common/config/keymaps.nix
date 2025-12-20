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

  moveToWindow = map (
    {
      key,
      direction,
    }:
    {
      key = "<C-${key}>";
      mode = [ "n" ];
      action = "<C-w>${key}";
      desc = "Go to ${direction} Window";
    }
  ) vimKeys;

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
    moveToWindow
    clearSearch

    # Resize window (idk I have never used this). Can be useful now that I know it
    # I don't use arrow anyway? so yeah???
    # TODO: https://github.com/0xm4n/resize.nvim/blob/main/lua/resize.lua the logic here looks good, but it's too short for a plugin so maybe just rewrite it
    # Or maybe this one for integration with Zellij? https://github.com/mrjones2014/smart-splits.nvim
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      desc = "Increase Window Height";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      desc = "Decrease Window Height";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      desc = "Decrease Window Height";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      desc = "Decrease Window Height";
    }
  ];

}
