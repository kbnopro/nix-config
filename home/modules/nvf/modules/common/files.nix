{
  ...
}: {
  config = {
    vim.utility.oil-nvim = {
      enable = true;
      setupOpts = {
        use_default_keymaps = false;
      };
    };
    vim.keymaps = [
      {
        key = "<leader>o";
        mode = ["n"];
        action = ":Oil<CR>";
        silent = true;
        desc = "Open Oil Explorer";
      }
    ];
  };
}
