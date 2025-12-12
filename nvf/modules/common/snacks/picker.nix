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
        function () Snacks.picker.smart() end
      '';
      desc = "Smart Find Files";
      lua = true;
      mode = "n";
    }
    # We might want the root option too, but let's just use the cwd one for now
    {
      key = "<leader>ff";
      action = ''
        function () Snacks.picker.files() end
      '';
      desc = "Smart Find Files";
      lua = true;
      mode = "n";
    }
    {
      key = "<leader>sg";
      action = ''
        function () Snacks.picker.grep() end
      '';
      desc = "Smart Find Files";
      lua = true;
      mode = "n";
    }
  ];
}
