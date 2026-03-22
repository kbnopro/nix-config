{ ... }:
{
  config.vim.assistant.copilot = {
    cmp.enable = true;
    setupOpts = {
      suggestion = {
        enabled = true;
        auto_trigger = true;
      };
    };
  };
}
