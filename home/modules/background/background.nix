{
  mylib,
  lib,
  pkgs,
  config,
  ...
}:
let
  pythonEnv = pkgs.python312.withPackages (ps: [
    ps.materialyoucolor
    ps.pillow
  ]);

  bgPath = config.background.path;

  generated =
    pkgs.runCommand "generate-color"
      {
        buildInputs = [ pythonEnv ];
      }
      ''
        python ${./color-generation.py} --path "${bgPath}" --termscheme "${./terminal/scheme-base.json}" --blend_bg_fg --transparency "opaque" --mode "dark" --term_fg_boost 0 --harmonize_threshold 15 > $out
      '';

  content = builtins.trace (builtins.readFile generated) (builtins.readFile generated);

  # Parse one line like:
  # "$darkmode: True;" into { darkmode = true; }
  parseLine =
    line:
    let
      # match groups: 1=key 2=value
      m = builtins.match ''\$(.+):[[:space:]]*(.+);'' line;
    in
    if m == null then
      null
    else
      let
        key = builtins.elemAt m 0;
        raw = builtins.elemAt m 1;

        valueStr = lib.strings.trim raw;

        value =
          if lib.strings.toLower valueStr == "true" then
            true
          else if lib.strings.toLower valueStr == "false" then
            false
          else
            valueStr; # fallback as string
      in
      {
        ${key} = value;
      };

  # Parse the whole file into an attrset
  parseVarsFile =
    content:
    let
      lines = lib.strings.splitString "\n" content;
      parsed = builtins.filter (x: x != null) (map parseLine lines);
    in
    lib.foldl' (acc: item: acc // item) { } parsed;

in
{
  options.background = {
    path = lib.mkOption {
      type = lib.types.path;
      default = mylib.relativeToRoot "home/background-images/cyan-moon.png";
    };
    color = lib.mkOption {
      type = lib.types.attrs;
    };

  };

  config = {
    background.color = parseVarsFile content;
  };
}
