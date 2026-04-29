{ ... }:
{
  # TODO: Smart splits is buggy and add a lot of overhead, so we might want to write a simple one in the future
  # Some useful functions: wincmd, vim.fn.winnr(), vim.fn.winnr('h')
  vim.utility.smart-splits = {
    enable = true;
    setupOpts = {
      multiplexer_integration = "zellij";
      # This is kinda buggy, but the "stop" is even worse
      zellij_move_focus_or_tab = true;
      at_edge = "wrap";
    };
    keymaps = {
      move_cursor_down = "<C-j>";
      move_cursor_up = "<C-k>";
      move_cursor_left = "<C-h>";
      move_cursor_right = "<C-l>";
      swap_buf_up = null;
      swap_buf_down = null;
      swap_buf_left = null;
      swap_buf_right = null;
    };
  };
}
