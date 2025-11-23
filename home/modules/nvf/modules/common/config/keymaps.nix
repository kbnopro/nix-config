{ ... }:
{
  config.vim.keymaps = builtins.concatLists [
    # Better up down
    (map(
      key: {
        inherit key;
        mode = ["n" "x"];
        action = "v:count == 0 ? 'gj' : 'j'";
        expr = true;
        desc = "Down";
        silent = true;
      }
    ) ["j" "<Down>"])

    (map(
      key: {
        inherit key;
        mode = ["n" "x"];
        action = "v:count == 0 ? 'gk' : 'k'";
        expr = true;
        desc = "Up";
        silent = true;
      }
    ) ["k" "<Up>"])

    # Move to window 
    (map (
      {key, posName}: {
        key = "<C-${key}>";
        mode = ["n"];
        action = "<C-w>${key}";
        desc = "Go to ${posName} Window";
      }
    ) [
        {
          key = "h";
          posName = "Left";
        }
        {
          key = "j";
          posName = "Down";
        }
        {
          key = "k";
          posName = "Up";
        }
        {
          key = "l";
          posName = "Right";
        }
      ]
    )
  ];

}
