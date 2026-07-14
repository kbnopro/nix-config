{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.vim.languages.prisma;

  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.dag) entryBefore;
in
{
  options = {
    vim.languages.prisma = {
      enable = lib.mkEnableOption "Prisma Config Language";
    };
  };

  config = lib.mkIf cfg.enable {
    vim.extraPackages = with pkgs; [
      prisma-language-server
    ];

    vim.luaConfigRC.lsp-util = entryBefore [ "lsp" ] ''
      util.get_prisma_lsp = function()
        local project_roots = vim.fs.find('node_modules', { path = root_dir, upward = true, limit = math.huge })
        for _, project_root in ipairs(project_roots) do
          local local_binary = project_root .. '/.bin/prisma-language-server'
          if vim.fn.executable(local_binary) == 1 then
            vim.notify('Using local prisma-language-server at ' .. local_binary)
            return { local_binary, '--stdio' }
          end
        end

        return {
          "${pkgs.prisma-language-server}/bin/prisma-language-server",
          "--stdio"
        };
      end
    '';

    vim.lsp.servers.prismals = {
      enable = true;
      cmd = mkLuaInline ''
        util.get_prisma_lsp()
      '';
      settings = {
        prisma = {
          prismaFmtBinPath = "";
        };
      };
      filetypes = [ "prisma" ];
      root_markers = [
        ".git"
        "package.json"
      ];
    };

    vim.treesitter = {
      enable = true;
      grammars = [ pkgs.vimPlugins.nvim-treesitter.grammarPlugins.prisma ];
    };
  };
}
