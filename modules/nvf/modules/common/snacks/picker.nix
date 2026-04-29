{ pkgs, ... }:

{
  vim.extraPackages = with pkgs; [
    fzf
    ripgrep
  ];

  vim.utility.snacks-nvim = {
    setupOpts = {
      picker.enabled = true;
    };
  };

  vim.keymaps = [
    # This seems interesting, although I haven't used this yet
    {
      key = "<leader><space>";
      action = ''
        Snacks.picker.smart
      '';
      desc = "Smart Find Files";
      lua = true;
      mode = "n";
    }
    # We might want the root option too, but let's just use the cwd one for now
    {
      key = "<leader>ff";
      action = ''
        Snacks.picker.files
      '';
      desc = "Find Files";
      lua = true;
      mode = "n";
    }
    {
      key = "<leader>sg";
      action = ''
        Snacks.picker.grep
      '';
      desc = "Smart Grep";
      lua = true;
      mode = "n";
    }
    {
      key = "<leader>sd";
      action = ''
        Snacks.picker.diagnostics
      '';
      desc = "Diagnostics";
      lua = true;
      mode = "n";
    }
    {
      key = "<leader>fb";
      action = ''
        Snacks.picker.buffers
      '';
      desc = "Buffers";
      lua = true;
      mode = "n";
    }
    {
      key = "<leader>sk";
      action = ''
        Snacks.picker.keymaps
      '';
      desc = "Keymaps";
      lua = true;
      mode = "n";
    }
  ];
}
