{ config, lib, ... }:
let
  cfg = config.vim.languages.markdown;
in
{
  config = lib.mkIf cfg.enable {
    vim.languages.markdown = {
      format.enable = true;
      extraDiagnostics.enable = true;
      lsp = {
        enable = true;
        servers = [ "marksman" ];
      };
      treesitter.enable = true;
      extensions.markview-nvim = {
        enable = true;
        setupOpts = {
          typst.enable = false;
          preview = {
            enable = false;
          };
        };
      };
    };

    vim.autocmds = [
      {
        event = [ "LspAttach" ];
        pattern = [ "*" ];
        callback = lib.generators.mkLuaInline ''
          function(e) 
            local client = vim.lsp.get_client_by_id(e.data.client_id)
            if client.name == "marksman" then
              -- Set up keymaps for Markdown LSP
              local buf = e.buf
              vim.keymap.set("n", "<leader>cp", "<CMD>Markview splitToggle<CR>", { buffer = buf, desc = "Toggle Markdown Preview" })
            end
          end
        '';
      }
    ];
  };
}
