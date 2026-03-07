{
  lib,
  pkgs,
  config,
  options,
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
        python ${./color-generation.py} --path "${bgPath}" --termscheme "${./base-terminal-scheme.json}" --blend_bg_fg --transparency "opaque" --mode "dark" --term_fg_boost 0 --harmonize_threshold 15 > $out
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

  color = parseVarsFile content;

  trimHash =
    string:
    if builtins.substring 0 1 string == "#" then
      builtins.substring 1 (builtins.stringLength string) string
    else
      string;

  colorAttrs =
    (
      # our default algorithm generates code with hash and non-string (boolean, etc) values
      color |> (lib.mapAttrs (k: v: if lib.isString v then trimHash v else v))
    )
    // {
      # extended attributes that are not generated but useful
      opacity = 0.90;
      withHashtag =
        # pick out all the color and add hash to it
        color |> (lib.filterAttrs (k: v: lib.isString v));
    };
in
{
  options.background = {
    path = lib.mkOption {
      type = lib.types.path;
      default = ../../background-images/blue-sunset.jpg;
    };
    colors = lib.mkOption {
      type = lib.types.attrs;
    };
  };

  config = lib.mkMerge [
    {
      background.colors = colorAttrs;
    }
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.sharedModules = [
        (
          { ... }:
          {
            # Options are inherited from the top-level, so should only be read only
            options.background = {
              path = lib.mkOption {
                type = lib.types.path;
                readOnly = true;
              };
              colors = lib.mkOption {
                type = lib.types.attrs;
                readOnly = true;
              };
            };

            config.background = {
              path = bgPath;
              colors = colorAttrs;
            };
          }
        )
      ];
    })
  ];
}
