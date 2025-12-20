{ color, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };

    luaConfigPost = ''
      local util = require("tokyonight.util")
      require("tokyonight").setup({
        on_colors = function(colors)
          colors.bg = "${color.surface}";
          colors.bg_float = "${color.surfaceContainer}";
          colors.bg_dark = "${color.surfaceContainer}";
          colors.bg_dark1 = "${color.surfaceContainerLowest}";
          colors.bg_hightlight = "${color.surfaceContainerHighest}";
          colors.bg_popup = "${color.surfaceContainer}";
          colors.bg_search = "${color.primaryContainer}";
          colors.bg_visual = "${color.secondaryContainer}";
        end,

        on_highlights = function(highlights, colors) 
          highlights.AlphaHeader = {
            fg = "${color.primary}"
          }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    '';
  };
}
