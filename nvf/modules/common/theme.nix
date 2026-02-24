{ colors, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };

    luaConfigPost = with colors.withHashtag; ''
      local util = require("tokyonight.util")
      require("tokyonight").setup({
        on_colors = function(colors)
          colors.bg = "${surfaceContainerLow}";
          colors.bg_float = "${surfaceContainer}";
          colors.bg_dark = "${surfaceContainer}";
          colors.bg_dark1 = "${surfaceContainerLowest}";
          colors.bg_hightlight = "${surfaceContainerHighest}";
          colors.bg_popup = "${surfaceContainer}";
          colors.bg_search = "${primaryContainer}";
          colors.bg_visual = "${secondaryContainer}";
        end,

        on_highlights = function(highlights, colors) 
          highlights.AlphaHeader = {
            fg = "${primary}"
          }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    '';
  };
}
