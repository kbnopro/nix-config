{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim.autocmds = [
    {
      event = [ "TextYankPost" ];
      callback = mkLuaInline ''
        function ()
          (vim.hl or vim.highlight).on_yank()
        end
      '';
      desc = "Highlight on yank";
    }
    {
      event = [ "VimResized" ];
      callback = mkLuaInline ''
        function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd("tabnext " .. current_tab)
          end
      '';
      desc = "Resize splits if window got resized";
    }
  ];
}
