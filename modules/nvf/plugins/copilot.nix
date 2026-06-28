{ ... }:
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
    };
    mappings.suggestion = {
      accept = "<A-l>";
      acceptWord = "<A-w>";
    };
  };
}
