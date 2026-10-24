{ pkgs, ... }:
{
  config.vim.assistant.copilot = {
    cmp.enable = true;
    setupOpts = {
      filetypes = {
        markdown = true;
      };
      suggestion = {
        enabled = true;
        auto_trigger = true;
      };
      server = {
        custom_server_filepath = "${pkgs.copilot-language-server}/bin/copilot-language-server";
      };
    };
    mappings.suggestion = {
      accept = "<A-l>";
      acceptWord = "<A-w>";
    };
  };
}
