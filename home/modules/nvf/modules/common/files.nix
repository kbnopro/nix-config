{
  ...
}: {
  config = {
    vim.utility.oil-nvim = {
      enable = true;
      setupOpts = {
        use_default_keymaps = false;
        delete_to_trash = true;
        keymaps = {
          "<CR>" =  "actions.select";
          "g." = { "@1" = "actions.toggle_hidden"; mode = "n"; };
          "g\\" = { "@1" = "actions.toggle_trash"; mode = "n"; };
          "-" = { "@1" = "actions.parent"; mode = "n"; };
        };      
      };
    };
    vim.keymaps = [
      {
        key = "<leader>o";
        mode = ["n"];
        action = "<CMD>Oil<CR>";
        silent = true;
        desc = "Open Oil Explorer";
      }
    ];
  };
}
