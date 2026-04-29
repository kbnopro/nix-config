{ ... }:
{
  vim.lsp = {
    enable = true;
    mappings = {
      # Short stuffs
      goToDeclaration = "gD";
      goToDefinition = "gd";
      goToType = "gt";
      listImplementations = "gi";
      listReferences = "gr";
      signatureHelp = "gK";
      hover = "K";
      nextDiagnostic = "]d";
      previousDiagnostic = "[d";

      # Longer stuffs
      openDiagnosticFloat = "<leader>cd";
      codeAction = "<leader>ca";
      renameSymbol = "<leader>cr";

      # Useless stuffs
      documentHighlight = null;
      format = null; # autoformat is on
      listWorkspaceSymbols = null;
      listWorkspaceFolders = null;
      addWorkspaceFolder = null;
      removeWorkspaceFolder = null;
      listDocumentSymbols = null;
      toggleFormatOnSave = null; # doesn't seem to be lsp related
    };
  };

  vim.keymaps = [
    {
      # This is useful for TS. Not yet tested tho.
      key = "<leader>cA";
      desc = "Source Action";
      mode = "n";
      lua = true;
      action = ''
        function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source" };
              diagnostics = {};
            };
          })
        end
      '';
    }
    {
      # Insert mode signature help
      key = "<C-k>";
      desc = "Signature Help";
      mode = "i";
      lua = true;
      action = ''
        function()          
          vim.lsp.buf.signature_help()
        end
      '';
    }
  ];
}
