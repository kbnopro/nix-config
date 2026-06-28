{ ... }:
{
  vim.keymaps = [
    {
      key = "<leader>gB";
      action = ''
        function() 
          Snacks.gitbrowse()
        end
      '';
      desc = "Git Browse (Open)";
      lua = true;
      mode = [
        "n"
        "x"
      ];
    }
    {
      key = "<leader>gY";
      action = ''
        function() 
          Snacks.gitbrowse({open = function(url) vim.fn.setreg('+', url) end, notify = false})
        end
      '';
      desc = "Git Browse (Copy)";
      lua = true;
      mode = [
        "n"
        "x"
      ];
    }
  ];
}
