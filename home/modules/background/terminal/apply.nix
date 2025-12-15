{
  lib,
  pkgs,
  config,
  ...
}:
let
  color = config.background.color;

  controlSeqTemp = builtins.readFile ./sequences.txt;

  replaceFromAttrs =
    attrs: str:
    let
      keys = builtins.attrNames attrs;
      values = map (key: attrs.${key}) keys;
      appendedKeys = map (key: "\$${key}") keys;
      processedValues = map (
        value:
        if (lib.strings.hasPrefix "#" value) then
          (builtins.substring 1 (builtins.stringLength value) value)
        else
          value
      ) values;
    in
    builtins.replaceStrings appendedKeys processedValues str;

  controlSeq = replaceFromAttrs color controlSeqTemp;

  myScript = pkgs.writeShellApplication {
    name = "apply-terminal";
    runtimeInputs = [
      pkgs.swww
    ];
    text = ''
      for file in /dev/pts/*; do
        if [[ $file =~ ^/dev/pts/[0-9]+$ ]]; then
          printf '%s' '${controlSeq}' > "$file" || true
        fi
      done

      printf '%s' '${controlSeq}' > "$HOME/test.txt" || true
    '';
  };

in
{
  home.activation.applyTerminal = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${myScript}/bin/apply-terminal
  '';
}
