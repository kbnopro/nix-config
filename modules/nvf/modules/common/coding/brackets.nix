{ ... }:

{
  config.vim = {
    mini.pairs = {
      enable = true;
      setupOpts = {
        modes = {
          insert = true;
          command = false;
          terminal = false;
        };
        skip_next = ''[=[[%w%%%'%[%"%.%`%$]]=]'';
        skip_ts = [ "string" ];
        skip_unbalanced = true;
        markdown = true;
      };
    };

    mini.surround = {
      enable = true;
      setupOpts = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          replace = "gsr";
        };
      };
    };
  };
}
