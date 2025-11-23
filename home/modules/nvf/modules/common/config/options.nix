{ ... }:
{
  config.vim.clipboard = {
    enable = true;
    registers = "unnamedplus";

    providers = {
      wl-copy.enable = true;
    };
  };

  config.vim.options = {
    # indent stuffs
    autoindent = true;
    shiftwidth = 2;
    tabstop = 2;
    expandtab = true;
    smartindent = true;

    termguicolors = true; # true color

    timeoutlen = 1000; # wait to finish sequence

    wrap = true;
    linebreak = true;
    wrapmargin = 0;
    textwidth = 0;
  };
}
