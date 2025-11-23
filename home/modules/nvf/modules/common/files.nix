{
  ...
}: {
  config = {
    vim.utility.oil-nvim = {
      enable = true;
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
