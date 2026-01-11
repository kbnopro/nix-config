{ ... }:

{
  vim.utility.smart-splits = {
    enable = true;
    setupOpts = {
      multiplexer_integration = "zellij";
      zellij_move_focus_or_tab = true;
    };
    keymaps = {
      move_cursor_down = "<C-j>";
      move_cursor_up = "<C-k>";
      move_cursor_left = "<C-h>";
      move_cursor_right = "<C-l>";
      resize_down = "<M-j>";
      resize_up = "<M-k>";
      resize_left = "<M-h>";
      resize_right = "<M-l>";
    };
  };

}
