{ config, lib, ... }:
let
  cfg = config.vim.languages.typst;
in
{
  config = lib.mkIf cfg.enable {
    vim.languages.typst = {
      format.enable = true;
      lsp = {
        enable = true;
        servers = [ "tinymist" ];
      };
      treesitter.enable = true;
      extensions.typst-preview-nvim.enable = true;
    };

    vim.autocmds = [
      {
        event = [ "LspAttach" ];
        pattern = [ "*" ];
        callback = lib.generators.mkLuaInline ''
          function(e) 
            local client = vim.lsp.get_client_by_id(e.data.client_id)
            if client.name == "tinymist" then
              -- Set up keymaps for Typst LSP
              local buf = e.buf
              vim.keymap.set("n", "<leader>cp", "<CMD>TypstPreviewToggle<CR>", { buffer = buf, desc = "Toggle Typst Preview" })
            end
          end
        '';
      }
    ];

  };
}
