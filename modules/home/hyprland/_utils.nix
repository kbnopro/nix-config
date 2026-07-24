{
  lib,
  ...
}:
rec {
  vimDirections = [
    {
      key = "h";
      direction = "l";
    }
    {
      key = "j";
      direction = "d";
    }
    {
      key = "k";
      direction = "u";
    }
    {
      key = "l";
      direction = "r";
    }
  ];

  arrowDirections = [
    {
      key = "LEFT";
      direction = "l";
    }
    {
      key = "DOWN";
      direction = "d";
    }
    {
      key = "UP";
      direction = "u";
    }
    {
      key = "RIGHT";
      direction = "r";
    }
  ];

  workspaces =
    (lib.range 1 10)
    |> (map (m: {
      key = lib.trivial.mod m 10;
      workspace = m;
    }));

  directions = vimDirections ++ arrowDirections;

  toLuaArgs =
    input:
    let
      # Wrap single items into a list so we can process everything uniformly
      argsList = if builtins.isList input then input else [ input ];
    in
    builtins.concatStringsSep ", " (map (lib.generators.toLua { }) argsList);

  mkBind = key: dsp: args: {
    _args = [
      key
      (lib.generators.mkLuaInline "hl.dsp.${dsp}(${toLuaArgs args})")
    ];
  };

  mkBindFlags = key: dsp: args: flags: {
    _args = [
      key
      (lib.generators.mkLuaInline "hl.dsp.${dsp}(${toLuaArgs args})")
      (lib.generators.mkLuaInline (toLuaArgs flags))
    ];
  };

  addModifier = modifier: input: input // { key = "${modifier} + ${lib.toString input.key}"; };

}
