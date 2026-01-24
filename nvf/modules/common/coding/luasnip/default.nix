{ ... }:

{
  vim.additionalRuntimePaths = [ "${./.}" ];

  vim.luaPackages = [ "jsregexp" ];

  vim.snippets.luasnip = {
    enable = true;
    loaders = ''
      require("luasnip.loaders.from_lua").load({ paths = { "${./lua/snippets}" } })
    '';
    setupOpts = {
      store_selection_keys = "<Tab>";
      enable_autosnippets = true;
      update_events = [
        "TextChanged"
        "TextChangedI"
      ];
    };
  };

  vim.keymaps = [
    {
      key = "<C-l>";
      mode = "i";
      action = "function() require('luasnip').jump(1) end";
      silent = true;
      desc = "Luasnip jump forward";
      lua = true;
    }
    {
      key = "<C-h>";
      mode = "i";
      action = "function() require('luasnip').jump(-1) end";
      silent = true;
      desc = "Luasnip jump backward";
      lua = true;
    }
  ];
}
