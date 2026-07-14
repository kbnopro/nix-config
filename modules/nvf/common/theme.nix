{
  colors,
  lib,
  ...
}:
let
  inherit (lib.nvim.dag) entryBefore;
in
{
  vim = {
    options.termguicolors = true;

    startPlugins = [ "tokyonight" ];

    luaConfigRC.theme = entryBefore [ "pluginConfigs" "lazyConfigs" ] (
      if (colors ? withHashtag) then
        with colors.withHashtag;
        # lua
        ''
          local util = require("tokyonight.util")
          require("tokyonight").setup({
            transparent = false;
            styles = {
              sidebars = "dark",
              floats = "dark",
            },

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
        ''
      else
        ""
    );
  };
}
